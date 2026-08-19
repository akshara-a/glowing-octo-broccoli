# System Design: Real-Time Traffic Estimation System

## 1. Overview

The system uses anonymized location and speed data from mobile devices to estimate real-time traffic on roads.

Basic flow:

Mobile Devices → API Gateway → Kafka/PubSub → Stream Processing → Map Matching → Traffic Aggregator → Traffic Store → Routing Engine

## 2. Location Updates

Mobile devices periodically send location information such as:

- Device ID
- Latitude
- Longitude
- Speed
- Timestamp

The system should be able to handle millions of location updates per second.

## 3. Map Matching

GPS coordinates are matched with the most likely road segment.

The system uses:

- GPS accuracy
- Road geometry
- Direction
- Speed
- Previous location

This helps avoid confusing parallel roads, service roads and parking areas.

## 4. Current Road Speed

For each road segment, the system calculates:

- Average speed
- Median speed
- Number of vehicles
- Speed variation
- Observation duration

Median speed is useful because one unusually slow vehicle should not affect the whole result.

## 5. Traffic Status

I would calculate:

Traffic Ratio = Current Average Speed / Expected Speed

For example:

Expected Speed = 60 km/h
Current Speed = 12 km/h

Traffic Ratio = 12 / 60 = 0.20

This can be classified as heavy traffic.

Traffic levels:

- GREEN → Normal
- YELLOW → Slight slowdown
- ORANGE → Moderate traffic
- RED → Heavy traffic

## 6. Traffic Confidence

One slow vehicle should not immediately mean heavy traffic.

The confidence score can depend on:

- Number of vehicles
- Speed consistency
- Observation duration
- Historical speed
- GPS accuracy

If only one vehicle is present, confidence is low. If many vehicles are moving slowly for several minutes, confidence becomes high.

## 7. Historical Traffic

The system stores historical traffic based on:

- Road segment
- Day of week
- Time of day

For example, if a road normally has a speed of around 60 km/h at 3 AM but the current speed is 8 km/h, the system can identify an unusual slowdown.

## 8. High-Level Architecture

Mobile Devices
      |
      v
API Gateway
      |
      v
Event Ingestion
      |
      v
Kafka / PubSub
      |
      v
Stream Processing
      |
      v
Map Matching
      |
      v
Traffic Aggregator
      |
      +----------------+
      |                |
      v                v
Current Traffic    Historical Data
      |
      v
Routing Engine
      |
      v
Map Application

## 9. Scalability

Assume there are 50 million active devices and each sends one update every 10 seconds.

50,000,000 / 10 = 5,000,000 events per second.

To handle this volume, I would use:

- Kafka partitions
- Multiple stream-processing servers
- Load balancing
- Horizontal scaling
- Distributed storage
- Replication

The system should provide traffic updates within around 5–30 seconds.

## 10. APIs

### Location API

POST /v1/location-events

Example request:

{
  "deviceId": "anon-123",
  "latitude": 12.9716,
  "longitude": 77.5946,
  "speed": 8.5,
  "timestamp": "2026-08-17T03:00:00Z"
}

### Traffic API

GET /v1/roads/{roadSegmentId}/traffic

Example response:

{
  "roadSegmentId": "R-98271",
  "averageSpeed": 11.2,
  "expectedSpeed": 58.5,
  "trafficLevel": "HEAVY",
  "confidence": 0.94
}

## 11. Data Model

### RoadSegment

- roadSegmentId
- startLatitude
- startLongitude
- endLatitude
- endLongitude
- speedLimit
- roadType
- length

### RoadTraffic

- roadSegmentId
- averageSpeed
- medianSpeed
- vehicleCount
- trafficLevel
- confidenceScore
- windowStart
- windowEnd

### HistoricalTraffic

- roadSegmentId
- dayOfWeek
- timeBucket
- averageSpeed
- p50Speed
- p90Speed

## 12. Stream Processing

Instead of processing every event separately, the system can use small time windows such as 30 seconds.

For example:

8, 10, 7, 9, 11, 6 km/h

Average = 8.5 km/h
Median = 8.5 km/h
Count = 6

The processor then updates the traffic status for that road.

## 13. Partitioning

I would use:

Partition Key = RoadSegmentId

This keeps events for the same road segment together and makes aggregation easier.

Geographic partitioning such as H3 or Geohash can also be used.

## 14. Routing

The routing engine should use expected travel time instead of only distance.

Example:

Road A:
5 km at 10 km/h = 30 minutes

Road B:
8 km at 50 km/h ≈ 9.6 minutes

Even though Road B is longer, it should be selected because it takes less time.

## 15. Edge Cases

- One vehicle → Keep confidence low.
- GPS jumping → Use map matching and previous location.
- Traffic signal → Ignore very short stops.
- Parking lot → Check road geometry and movement.
- People walking → Use speed to filter them.
- Bus with many phones → Detect similar movement patterns.
- Train → Check movement direction and railway data.
- Accident at 3 AM → Detect sudden speed reduction from multiple vehicles.
- No devices → Use historical data with low confidence.
- Incorrect GPS → Filter inaccurate locations.
- Stadium event → Detect unusual concentration of devices.
- Tunnel → Use last known position and historical data.
- Rural area → Depend more on historical data.

## 16. Privacy

The system should protect user privacy by using:

- Anonymous or rotating device IDs
- Encryption
- Data aggregation
- Minimum population thresholds
- Limited data retention
- Access control

The system needs to know where devices are moving and how fast, not who owns them.

## 17. Why Kafka?

Kafka is useful because it supports:

- High-throughput event ingestion
- Partitioning
- Replay
- Consumer scaling
- Fault tolerance

## 18. Why Not PostgreSQL for Every GPS Event?

Writing millions of GPS events per second directly to PostgreSQL would create a very high database load.

Kafka can first handle the event stream, while stream processing aggregates the data and stores useful traffic information.

## 19. What if Kafka Goes Down?

The system can use:

- Multiple brokers
- Replication
- Producer retries
- Consumer checkpoints
- Multi-AZ deployment

This helps the system recover from failures.

## 20. Consistency

Traffic information does not require strong consistency.

A few seconds of difference between users is acceptable, so the system can use eventual consistency and prioritize availability.

## 21. Final Design

The system collects anonymized mobile-device location data and processes it using Kafka and stream processing.

Map matching identifies the road segment, and the traffic aggregator calculates current speed, vehicle count and traffic confidence.

Historical traffic data helps detect unusual slowdowns, especially when there are very few vehicles at times such as 3 AM.

Finally, the routing engine uses current traffic to calculate expected travel time and select the fastest route.

The design provides scalability, low latency, fault tolerance and privacy.