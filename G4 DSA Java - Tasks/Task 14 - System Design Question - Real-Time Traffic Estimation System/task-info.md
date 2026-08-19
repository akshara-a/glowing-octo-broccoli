# System Design Question: Real-Time Traffic Estimation System

## Problem Statement

Design a **Google Maps–like real-time traffic estimation system**.

Assume that the system **does not depend on traffic cameras, physical road sensors, or police reports**.

Instead, the system should estimate traffic conditions using anonymized location and movement data received from users' mobile devices.

The system should be able to answer questions such as:

- Is a particular road congested right now?
- What is the current average speed on a road?
- Is traffic slower than normal?
- How can traffic be detected even at **3:00 AM**?
- How should the system behave when only one or two vehicles are present?
- How can traffic information be used to calculate the fastest route?

---

## Example Scenario

Consider a road where the normal speed at 3:00 AM is approximately:

```text
60 km/h
```

The system receives location updates from multiple devices:

```text
Device A → 9 km/h
Device B → 7 km/h
Device C → 11 km/h
Device D → 6 km/h
Device E → 8 km/h
```

All these devices appear to be travelling along the same road segment.

The system should determine:

```text
Normal Speed       = 60 km/h
Observed Speed     = 8 km/h
Number of Vehicles = 5
Duration           = 4 minutes

Traffic Status → Heavy Traffic
```

However, if only one device reports:

```text
Device A → 5 km/h
```

the system should **not immediately classify the road as congested**.

---

# Functional Requirements

## 1. Receive Location Updates

Mobile devices periodically send anonymized location information.

Example:

```json
{
  "deviceId": "anonymous-device-123",
  "latitude": 12.9716,
  "longitude": 77.5946,
  "speed": 8.5,
  "timestamp": "2026-08-17T03:00:00Z"
}
```

The system should support millions of such events.

---

## 2. Map Matching

GPS coordinates do not directly tell us which road the user is travelling on.

The system should determine the most likely road segment.

Example:

```text
GPS Location
     ↓
12.9716, 77.5946
     ↓
Map Matching
     ↓
Road Segment ID: R-98271
```

The system should handle GPS inaccuracies.

For example:

```text
                    Road A
──────────────────────────────

             X  ← GPS position

──────────────────────────────
                  Service Road
```

The system needs to decide whether the device is on:

- Road A
- Service road
- Nearby parking lot
- Another parallel road

---

## 3. Calculate Current Road Speed

For each road segment, calculate statistics such as:

```text
Average Speed
Median Speed
Number of Vehicles
Speed Variance
Observation Duration
```

Example:

```text
Road Segment: R-98271

Vehicle Count: 34
Average Speed: 11 km/h
Median Speed: 9 km/h
Normal Speed: 58 km/h
```

---

## 4. Determine Traffic Status

Classify each road segment.

For example:

```text
GREEN  → Normal traffic
YELLOW → Slight slowdown
ORANGE → Moderate traffic
RED    → Heavy traffic
```

Possible logic:

```text
Traffic Ratio =
Current Average Speed / Expected Speed
```

Example:

```text
Expected Speed = 60 km/h
Current Speed  = 12 km/h

12 / 60 = 0.20
```

Therefore:

```text
Traffic Status = RED
```

---

# Important Challenge: Low Traffic at 3 AM

At 3 AM, there may be very few vehicles.

Suppose the system receives:

```text
Vehicle A → 5 km/h
```

This alone should not mean:

```text
RED → Heavy Traffic
```

The driver might be:

- Parking
- Stopping
- Entering a building
- Driving slowly intentionally
- Experiencing inaccurate GPS

Therefore, design a **traffic confidence score**.

Example:

```text
TrafficConfidence =
    f(
        numberOfVehicles,
        speedConsistency,
        observationDuration,
        historicalSpeed,
        GPSAccuracy
    )
```

Example:

```text
1 vehicle
↓
Low Confidence
↓
Do not classify congestion
```

Compared with:

```text
25 vehicles
↓
Most moving at 5–10 km/h
↓
Normal speed = 60 km/h
↓
Observed for 5 minutes
↓
High Confidence
↓
Heavy Traffic
```

---

# Historical Traffic

The system should maintain historical traffic data.

Example:

```text
Road R-98271

Monday 3 AM     → 61 km/h
Tuesday 3 AM    → 59 km/h
Wednesday 3 AM  → 62 km/h
Thursday 3 AM   → 60 km/h
```

Current observation:

```text
Friday 3 AM → 8 km/h
```

The system can detect that this is highly unusual.

---

# High-Level Architecture

Design something similar to:

```text
               Mobile Devices
                     │
                     │ GPS events
                     ▼
            ┌──────────────────┐
            │ API Gateway      │
            └────────┬─────────┘
                     │
                     ▼
            ┌──────────────────┐
            │ Event Ingestion  │
            └────────┬─────────┘
                     │
                     ▼
               Kafka / PubSub
                     │
                     ▼
          ┌──────────────────────┐
          │ Stream Processing    │
          │ Flink / Spark/etc.   │
          └──────────┬───────────┘
                     │
                     ▼
             ┌───────────────┐
             │ Map Matching  │
             └───────┬───────┘
                     │
                     ▼
            Road Segment Events
                     │
                     ▼
          ┌─────────────────────┐
          │ Traffic Aggregator  │
          └──────────┬──────────┘
                     │
              ┌──────┴───────┐
              ▼              ▼
       Current Traffic   Historical Data
           Store
              │
              ▼
        Routing Engine
              │
              ▼
          Google Maps
```

---

# Non-Functional Requirements

The system should support:

- Millions of active users
- Millions of location updates per second
- Near real-time traffic updates
- Low latency
- High availability
- Horizontal scalability
- Fault tolerance
- Privacy protection
- Efficient geospatial queries

Target traffic information freshness could be approximately:

```text
5–30 seconds
```

rather than requiring every GPS event to immediately reach every user.

---

# Capacity Estimation

Assume:

```text
50 million active devices
```

Each device sends one location update every:

```text
10 seconds
```

Calculate:

```text
50,000,000 / 10
```

which gives approximately:

```text
5 million location events / second
```

Discuss how the system would handle this volume.

---

# API Design

Example location ingestion API:

```http
POST /v1/location-events
```

Request:

```json
{
  "deviceId": "anon-123",
  "latitude": 12.9716,
  "longitude": 77.5946,
  "speed": 8.5,
  "timestamp": "2026-08-17T03:00:00Z"
}
```

Example traffic API:

```http
GET /v1/roads/{roadSegmentId}/traffic
```

Response:

```json
{
  "roadSegmentId": "R-98271",
  "averageSpeed": 11.2,
  "expectedSpeed": 58.5,
  "trafficLevel": "HEAVY",
  "confidence": 0.94,
  "updatedAt": "2026-08-17T03:00:10Z"
}
```

---

# Data Model

A road segment could look like:

```text
RoadSegment

roadSegmentId
startLatitude
startLongitude
endLatitude
endLongitude
speedLimit
roadType
length
```

Current traffic:

```text
RoadTraffic

roadSegmentId
averageSpeed
medianSpeed
vehicleCount
trafficLevel
confidenceScore
windowStart
windowEnd
```

Historical traffic:

```text
HistoricalTraffic

roadSegmentId
dayOfWeek
timeBucket
averageSpeed
p50Speed
p90Speed
```

---

# Stream Processing

Instead of processing every event independently, use time windows.

For example:

```text
Road R123
```

Events during:

```text
03:00:00 – 03:00:30
```

could be grouped together.

```text
Vehicle speeds:

8
10
7
9
11
6
```

The stream processor calculates:

```text
Average = 8.5 km/h
Median  = 8.5 km/h
Count   = 6
```

Then publishes:

```text
R123 → Heavy Traffic
```

---

# Partitioning Strategy

A major design question is:

> How should Kafka or the processing system be partitioned?

One approach is:

```text
Partition Key = RoadSegmentId
```

Therefore:

```text
R100 → Partition 1
R101 → Partition 4
R102 → Partition 2
R103 → Partition 1
```

Events belonging to the same road segment reach the same processing partition.

This makes aggregation easier.

Another possibility is geographic partitioning using:

```text
Geohash
H3
S2 Cells
```

Example:

```text
India
└── Karnataka
      └── Bengaluru
           └── H3 Cell
                └── Road Segments
```

---

# Routing Integration

Traffic information must eventually influence route calculation.

Traditional shortest route:

```text
Edge Weight = Distance
```

Traffic-aware routing:

```text
Edge Weight = Expected Travel Time
```

For example:

```text
Road A

Distance = 5 km
Current Speed = 10 km/h

Travel Time = 30 minutes
```

Compared with:

```text
Road B

Distance = 8 km
Current Speed = 50 km/h

Travel Time ≈ 9.6 minutes
```

Although Road B is longer, the routing engine should recommend Road B.

---

# Edge Cases to Discuss

Consider how your system handles:

1. Only one vehicle on the road.
2. GPS location jumping between two parallel roads.
3. A user stopping at a traffic signal.
4. Vehicles inside a parking lot.
5. Hundreds of people walking beside a road.
6. A bus containing 40 mobile phones.
7. A train running beside a highway.
8. A temporary road closure.
9. An accident at 3 AM.
10. No devices providing data for a road.
11. Devices sending incorrect GPS coordinates.
12. A stadium event causing thousands of phones to move together.
13. Tunnels where GPS signal is unavailable.
14. Rural areas with very few users.

---

# Privacy Considerations

The system should not require identifying individual users.

Consider:

- Anonymous/device-rotating identifiers
- Location data retention limits
- Aggregation
- Minimum population thresholds
- Encryption
- Access control
- Preventing individual movement reconstruction

The traffic system primarily needs:

```text
Where are devices moving?
How fast are they moving?
Which road segment are they probably using?
```

rather than:

```text
Who owns this device?
```

---

# Interview Follow-Up Questions

## 1. Why Kafka?

Explain how Kafka helps with:

- High-throughput event ingestion
- Partitioning
- Replay
- Consumer scaling
- Fault tolerance

## 2. Why not write every GPS location directly to PostgreSQL?

Discuss:

```text
Millions of writes/sec
+
real-time processing
+
short-lived event data
```

versus traditional transactional database workloads.

## 3. How would you identify the correct road from GPS coordinates?

Discuss:

- Map matching
- Geospatial indexing
- Heading
- Speed
- Previous location
- Road geometry

## 4. How would you detect an accident?

For example:

```text
60 km/h
60 km/h
58 km/h
   ↓
10 km/h
5 km/h
0 km/h
```

Sudden speed collapse across multiple vehicles may indicate an incident.

## 5. How do you prevent one slow driver from creating fake traffic?

Use:

- Minimum observation count
- Median instead of only average
- Outlier filtering
- Confidence score
- Time windows
- Historical comparisons

## 6. What happens if Kafka goes down?

Discuss:

- Replication
- Multiple brokers
- Producer retries
- Consumer checkpoints
- Multi-AZ deployment

## 7. What consistency model is required?

Traffic information usually does **not** require strong consistency.

```text
User A sees traffic from 10 seconds ago
User B sees traffic from 15 seconds ago
```

This is normally acceptable.

Therefore, the system can favor:

```text
Availability
+
Partition tolerance
+
Eventual consistency
```

---

# Final Interview Question

> **Design a globally scalable real-time traffic estimation system similar to Google Maps. The system cannot rely on cameras, dedicated road sensors, or police reports. It should infer traffic conditions using anonymized mobile-device location signals, historical traffic patterns, and road-map information. Explain your APIs, data model, event ingestion architecture, map matching, stream processing, partitioning strategy, traffic confidence algorithm, storage, routing integration, scalability, reliability, privacy, and handling of low-data situations such as traffic at 3 AM.**
 
