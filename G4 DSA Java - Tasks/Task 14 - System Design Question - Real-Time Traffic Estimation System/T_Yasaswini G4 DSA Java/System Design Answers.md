# Real-Time Traffic Estimation System -- Complete System Design Answer

## 1. Problem Understanding

The goal is to design a Google Maps--like system that estimates live
traffic using anonymized GPS and movement data from mobile devices.

The system must: - Identify the road segment on which a device is
travelling. - Calculate current speed and traffic conditions for each
road segment. - Compare current speed with the normal speed for that
road and time. - Handle low-data situations, especially at night. -
Estimate traffic confidence so one slow vehicle does not create a false
traffic alert. - Use traffic information to calculate the fastest
route. - Support millions of location events per second while protecting
user privacy.

The system does not depend on traffic cameras, physical road sensors, or
police reports.

------------------------------------------------------------------------

## 2. High-Level Architecture

``` text
             Mobile Devices
                    |
             GPS Location Events
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
             (Flink / Spark)
                    |
                    v
               Map Matching
                    |
                    v
          Road Segment Aggregation
                    |
             +------+------+
             |             |
             v             v
       Current Traffic  Historical Traffic
           Store             Store
             |             |
             +------+------+
                    |
                    v
              Routing Engine
                    |
                    v
             Traffic API / Maps
```

### Component explanation

1.  **Mobile devices:** Send anonymized location, speed, heading,
    accuracy, and timestamp.
2.  **API Gateway:** Receives requests, validates them, applies rate
    limits, and distributes traffic.
3.  **Event ingestion:** Accepts high-volume location events and
    publishes them to Kafka.
4.  **Kafka:** Buffers events and distributes them to processing
    services.
5.  **Stream processing:** Processes events in short time windows.
6.  **Map matching:** Finds the most likely road segment for each
    location.
7.  **Traffic aggregator:** Calculates speed statistics and confidence
    for each road.
8.  **Storage:** Keeps current traffic and historical traffic
    separately.
9.  **Routing engine:** Uses estimated travel time to calculate the
    fastest route.
10. **Traffic API:** Provides the latest traffic information to
    applications.

------------------------------------------------------------------------

## 3. Functional Requirements

1.  Receive anonymized GPS updates from mobile devices.
2.  Map GPS coordinates to the correct road segment.
3.  Calculate average speed, median speed, vehicle count, and speed
    variance.
4.  Compare current speed with expected historical speed.
5.  Classify traffic as GREEN, YELLOW, ORANGE, or RED.
6.  Calculate a confidence score for each traffic estimate.
7.  Maintain historical traffic information by road, day, and time.
8.  Provide current traffic information through APIs.
9.  Use traffic conditions in route calculation.
10. Handle inaccurate GPS, low vehicle counts, tunnels, road closures,
    and other edge cases.

------------------------------------------------------------------------

## 4. Non-Functional Requirements

-   **Scalability:** Support millions of active devices and millions of
    events per second.
-   **Low latency:** Update traffic information approximately every
    5--30 seconds.
-   **Availability:** Keep the system usable even if some services fail.
-   **Fault tolerance:** Recover from broker, processor, or server
    failures.
-   **Accuracy:** Filter incorrect GPS points and unreliable speed
    readings.
-   **Privacy:** Avoid identifying individual users or reconstructing
    personal journeys.
-   **Consistency:** Eventual consistency is acceptable because traffic
    data changes continuously.
-   **Geospatial efficiency:** Find nearby roads and road segments
    quickly.

------------------------------------------------------------------------

## 5. Capacity Estimation

Assume: - Active devices = 50 million. - Each device sends one update
every 10 seconds.

Calculation:

``` text
Events per second = 50,000,000 / 10
                  = 5,000,000 events/second
```

The system must handle approximately **5 million location events per
second**.

### How to handle this volume

1.  Deploy multiple API gateway instances behind a load balancer.
2.  Use Kafka with many partitions and broker nodes.
3.  Process events using a distributed stream-processing cluster.
4.  Partition events geographically or by road segment.
5.  Batch and aggregate events instead of writing every raw event to a
    database.
6.  Scale consumers horizontally based on event volume and processing
    lag.
7.  Apply sampling and adaptive update frequency where appropriate.
8.  Use in-memory or distributed caches for frequently requested current
    traffic data.

------------------------------------------------------------------------

## 6. Location Ingestion API

### Endpoint

``` http
POST /v1/location-events
Content-Type: application/json
```

### Request

``` json
{
  "deviceId": "anon-123",
  "latitude": 12.9716,
  "longitude": 77.5946,
  "speed": 8.5,
  "heading": 90,
  "gpsAccuracy": 8,
  "timestamp": "2026-08-17T03:00:00Z"
}
```

### Processing steps

1.  Validate latitude and longitude ranges.
2.  Validate timestamp and reject very old or future-dated events.
3.  Check speed and GPS accuracy.
4.  Use a rotating anonymous identifier rather than a permanent personal
    identifier.
5.  Publish the valid event to Kafka.
6.  Return an acknowledgement without waiting for the complete traffic
    calculation.

### Example response

``` json
{
  "status": "accepted",
  "message": "Location event received"
}
```

------------------------------------------------------------------------

## 7. Map Matching

GPS coordinates alone do not identify the road being used. A device may
be close to multiple roads, service roads, or parking areas.

### Map-matching process

1.  Use a geospatial index to find road segments near the GPS
    coordinate.
2.  Check the distance between the GPS point and each candidate road.
3.  Compare device heading with the direction of each road.
4.  Compare the current point with the previous location.
5.  Check whether the device's speed is reasonable for the candidate
    road.
6.  Select the most likely road segment.
7.  Reject the point or mark it uncertain if no candidate is reliable.

### Example

``` text
GPS coordinate
      |
      v
Find nearby road segments
      |
      v
Check distance + heading + previous location
      |
      v
Select most likely road
      |
      v
Road Segment ID: R-98271
```

### Handling parallel roads

If two roads are close together, distance alone is not enough. The
system should also compare heading, road direction, previous matched
segment, and road connectivity.

A map-matching algorithm such as a Hidden Markov Model can combine these
observations to select the most likely road path.

------------------------------------------------------------------------

## 8. Current Road Speed Calculation

For each road segment, collect valid vehicle speed observations within a
short time window, such as 30 seconds.

Example:

``` text
Road Segment: R-98271

Speeds:
8, 10, 7, 9, 11, 6 km/h
```

Calculations:

``` text
Average Speed = (8 + 10 + 7 + 9 + 11 + 6) / 6
              = 8.5 km/h

Median Speed  = (8 + 10 + 7 + 9 + 11 + 6) sorted
              = (8 + 9) / 2
              = 8.5 km/h

Vehicle Count = 6
```

The system should calculate: - Average speed. - Median speed. - Vehicle
count. - Speed variance. - Observation duration. - GPS quality. - Last
update time.

The median is useful because it is less affected by one unusually slow
or fast vehicle.

------------------------------------------------------------------------

## 9. Traffic Status Classification

Compare the current speed with the expected speed for the same road and
time period.

Formula:

``` text
Traffic Ratio = Current Average Speed / Expected Speed
```

Example:

``` text
Expected Speed = 60 km/h
Current Speed  = 12 km/h

Traffic Ratio = 12 / 60 = 0.20
```

A possible classification is:

  Traffic ratio   Traffic status     Display
  --------------- ------------------ ---------
  0.75--1.00      Normal             GREEN
  0.50--0.75      Slight slowdown    YELLOW
  0.25--0.50      Moderate traffic   ORANGE
  Below 0.25      Heavy traffic      RED

These are example thresholds. In a real system, thresholds should be
calibrated using road type, local driving patterns, and historical data.

A very low speed should not automatically mean heavy traffic. The system
must first check the confidence score and minimum observation
requirements.

------------------------------------------------------------------------

## 10. Traffic Confidence Score

A confidence score indicates how reliable the traffic estimate is.

It can use: - Number of unique devices. - Consistency of observed
speeds. - Observation duration. - GPS accuracy. - Historical traffic
comparison. - Whether the devices appear to be travelling on the road.

One possible conceptual formula is:

``` text
Confidence =
    0.30 × DeviceCountScore
  + 0.20 × SpeedConsistencyScore
  + 0.20 × DurationScore
  + 0.15 × GPSQualityScore
  + 0.15 × HistoricalSupportScore
```

Each score is normalized between 0 and 1. The weights are illustrative
and should be tuned using real data.

### Example: One vehicle at 3 AM

``` text
Observed speed = 5 km/h
Vehicle count  = 1

Result:
Low confidence
Traffic status = UNKNOWN / INSUFFICIENT DATA
```

The system should not classify the road as congested based on one
device.

### Example: Multiple vehicles at 3 AM

``` text
Observed speeds = 5, 7, 8, 9, 10 km/h
Vehicle count   = 25
Expected speed  = 60 km/h
Duration        = 5 minutes

Result:
High confidence
Traffic status = HEAVY
```

The important point is that traffic detection does not depend only on
the time of day. It depends on the amount and quality of evidence.

### Low-data fallback

When there are not enough live observations: 1. Do not report a
confirmed live congestion condition. 2. Use historical speed for that
road and time as an estimate. 3. Mark the result as historical or low
confidence. 4. Increase confidence only when fresh, independent
observations arrive.

------------------------------------------------------------------------

## 11. Historical Traffic Storage

Historical data helps the system understand normal traffic patterns.

Example:

``` text
Road R-98271

Monday 3 AM     = 61 km/h
Tuesday 3 AM    = 59 km/h
Wednesday 3 AM  = 62 km/h
Thursday 3 AM   = 60 km/h
Friday 3 AM     = 8 km/h
```

The current Friday speed is much lower than the historical pattern. This
may indicate an unusual slowdown.

Store historical aggregates by: - Road segment. - Day of week. - Time
bucket. - Average speed. - Median speed. - 90th percentile speed. -
Number of observations.

Historical data should be updated periodically and should not be treated
as proof of a current incident.

------------------------------------------------------------------------

## 12. Data Model

### RoadSegment

  Field            Description
  ---------------- -------------------------------------
  roadSegmentId    Unique road segment ID
  startLatitude    Starting latitude
  startLongitude   Starting longitude
  endLatitude      Ending latitude
  endLongitude     Ending longitude
  speedLimit       Legal or configured speed limit
  roadType         Highway, street, service road, etc.
  length           Segment length

### RoadTraffic

  Field             Description
  ----------------- ----------------------------------------
  roadSegmentId     Road segment ID
  averageSpeed      Current average speed
  medianSpeed       Current median speed
  vehicleCount      Number of unique contributing devices
  trafficLevel      GREEN, YELLOW, ORANGE, RED, or UNKNOWN
  confidenceScore   Reliability score
  windowStart       Start of aggregation window
  windowEnd         End of aggregation window
  updatedAt         Last update time

### HistoricalTraffic

  Field           Description
  --------------- --------------------------
  roadSegmentId   Road segment ID
  dayOfWeek       Day of the week
  timeBucket      Time interval
  averageSpeed    Historical average speed
  p50Speed        Historical median speed
  p90Speed        90th percentile speed

Raw location events should have a short retention period. Long-term
storage should preferably contain aggregated traffic statistics rather
than identifiable movement histories.

------------------------------------------------------------------------

## 13. Stream Processing

Processing each event separately does not provide a stable traffic
estimate. Instead, group events by road segment and time window.

Example:

``` text
Road R123
Time window: 03:00:00–03:00:30

Speeds:
8, 10, 7, 9, 11, 6 km/h
```

The stream processor calculates:

``` text
Average speed = 8.5 km/h
Median speed  = 8.5 km/h
Vehicle count = 6
```

Then it: 1. Checks the minimum number of unique devices. 2. Calculates
speed statistics. 3. Calculates the confidence score. 4. Compares
current speed with historical speed. 5. Assigns a traffic status. 6.
Publishes the latest road traffic result. 7. Stores the aggregate in the
current traffic store.

Use event-time windows and handle late or out-of-order events with a
suitable watermark policy.

------------------------------------------------------------------------

## 14. Partitioning Strategy

A useful Kafka partition key is:

``` text
RoadSegmentId
```

Example:

``` text
R100 → Partition 1
R101 → Partition 4
R102 → Partition 2
R103 → Partition 1
```

Events for the same road segment are routed to the same partition. This
makes aggregation easier and preserves ordering within that partition.

### Geographic partitioning

The system can also use geographic cells such as: - Geohash. - H3. - S2
Cells.

A geographic cell helps locate nearby road segments and distribute
map-matching work.

A practical design can first use geographic cells to find candidate
roads, then partition aggregation events by road segment ID.

Very busy road segments may create hot partitions. The system can
address this with local pre-aggregation, careful partition assignment,
or a two-stage aggregation process.

------------------------------------------------------------------------

## 15. Storage Design

Use different storage systems for different workloads.

  -----------------------------------------------------------------------
  Data                                Suitable storage
  ----------------------------------- -----------------------------------
  Road map and road metadata          Geospatial database or relational
                                      database

  Recent traffic state                Redis or another low-latency
                                      key-value store

  Historical traffic aggregates       Time-series or analytical database

  Raw event buffer                    Kafka

  Long-term analytical data           Data lake or warehouse
  -----------------------------------------------------------------------

Do not write every GPS event directly to PostgreSQL. Millions of small
writes per second can overload a traditional transactional database, and
most raw events are short-lived.

Instead: 1. Ingest events into Kafka. 2. Process and aggregate them. 3.
Write compact traffic summaries to storage. 4. Keep only the required
raw data for a limited period.

------------------------------------------------------------------------

## 16. Routing Integration

The routing engine should minimize expected travel time, not only
distance.

Traditional routing:

``` text
Edge weight = Distance
```

Traffic-aware routing:

``` text
Edge weight = Expected travel time
```

Formula:

``` text
Travel Time = Road Distance / Current Estimated Speed
```

### Example: Road A

``` text
Distance = 5 km
Speed    = 10 km/h

Travel time = 5 / 10 hours
            = 30 minutes
```

### Example: Road B

``` text
Distance = 8 km
Speed    = 50 km/h

Travel time = 8 / 50 hours
            = 0.16 hours
            = 9.6 minutes
```

Road B is longer but faster. Therefore, the routing engine should prefer
Road B if the full route calculation confirms it has the lower total
expected travel time.

Algorithms such as Dijkstra or A\* can be used with travel time as the
edge weight. The system should refresh route weights as traffic updates
arrive.

------------------------------------------------------------------------

## 17. Edge Case Handling

  -----------------------------------------------------------------------
  Edge case                           System handling
  ----------------------------------- -----------------------------------
  1\. Only one vehicle on the road    Low confidence; do not confirm
                                      congestion. Use historical estimate
                                      if available.

  2\. GPS jumps between parallel      Use heading, previous location,
  roads                               road geometry, and map matching.
                                      Reject uncertain points.

  3\. User stops at a traffic signal  A single stopped device should not
                                      determine road traffic. Use
                                      multiple devices and a time window.

  4\. Vehicles inside a parking lot   Map matching should identify the
                                      parking area or reject the point as
                                      a road observation.

  5\. People walking beside a road    Use speed, movement pattern,
                                      heading, and road type to filter
                                      pedestrian movement.

  6\. Bus with 40 mobile phones       Reduce correlated samples and avoid
                                      treating every phone as an
                                      independent vehicle.

  7\. Train beside a highway          Use speed, heading, map geometry,
                                      and transport-mode classification
                                      to avoid matching the train to the
                                      road.

  8\. Temporary road closure          Detect reports of near-zero
                                      movement or closure information,
                                      validate it, and update the road
                                      graph temporarily.

  9\. Accident at 3 AM                Detect sudden speed reduction
                                      across multiple independent devices
                                      and raise an incident candidate.

  10\. No devices on a road           Show no live data or a historical
                                      estimate with low confidence.

  11\. Incorrect GPS coordinates      Validate coordinate ranges,
                                      accuracy, speed, and movement
                                      consistency; reject outliers.

  12\. Stadium event                  Use unique-device counts,
                                      correlated movement detection, and
                                      geographic aggregation to avoid
                                      false conclusions.

  13\. Tunnels without GPS            Use the last reliable road match
                                      and road connectivity for a limited
                                      time; reduce confidence until fresh
                                      data returns.

  14\. Rural areas with few users     Use historical patterns and clearly
                                      mark estimates as low confidence.
  -----------------------------------------------------------------------

------------------------------------------------------------------------

## 18. Accident Detection

An accident or incident may cause a sudden speed reduction across
several vehicles.

Example:

``` text
Before:
60 km/h
60 km/h
58 km/h

After:
10 km/h
5 km/h
0 km/h
```

Possible detection process:

1.  Compare current speed with recent and historical speed.
2.  Identify a sudden speed drop.
3.  Check whether several independent devices show a similar slowdown.
4.  Confirm that the slowdown lasts for a minimum period.
5.  Check nearby road segments for the same pattern.
6.  Create an incident candidate with a confidence score.
7.  Update traffic information when the evidence is sufficient.

A speed drop alone cannot prove that an accident occurred. It may also
be caused by a signal, roadwork, or a temporary obstruction.

------------------------------------------------------------------------

## 19. Why Kafka?

Kafka is useful because it provides:

1.  **High throughput:** Handles a large number of incoming events.
2.  **Partitioning:** Distributes events across partitions and
    consumers.
3.  **Replay:** Retains events so they can be processed again when
    required.
4.  **Consumer scaling:** Multiple consumers can process partitions in
    parallel.
5.  **Fault tolerance:** Replicated partitions help protect against
    broker failures.
6.  **Buffering:** Separates event ingestion from downstream processing.

Kafka allows the ingestion service to accept events even when
traffic-processing services are temporarily slower.

------------------------------------------------------------------------

## 20. Why Not Store Every GPS Event Directly in PostgreSQL?

Writing millions of individual location updates per second directly to
PostgreSQL is not efficient for this workload.

Problems include: - Very high write load. - Increased database
connection and transaction overhead. - Large storage requirements. -
Heavy indexing and maintenance costs. - Difficulty separating ingestion
from processing.

Kafka is better suited to buffering high-volume events. Stream
processors can aggregate those events and write smaller results to
databases.

PostgreSQL can still store road metadata, configuration, and other
relational data.

------------------------------------------------------------------------

## 21. What Happens If Kafka Goes Down?

The system should use: - Multiple Kafka brokers. - Replication across
availability zones. - Producer retries and appropriate
acknowledgements. - Durable replicated event storage. - Monitoring and
alerts. - Consumer checkpoints or offsets. - Recovery procedures for
failed brokers.

If Kafka is temporarily unavailable, producers can retry or buffer a
limited amount of data locally, subject to privacy and storage limits.
Once Kafka recovers, events can be published again. Duplicate events
should be handled using event IDs or deduplication logic.

------------------------------------------------------------------------

## 22. Consistency Model

Strong consistency is not necessary for every traffic update.

For example:

``` text
User A sees traffic data that is 10 seconds old.
User B sees traffic data that is 15 seconds old.
```

This is normally acceptable for traffic estimation.

The system can use eventual consistency because: - Traffic changes
continuously. - Small update delays are acceptable. - High availability
and low latency are important. - New traffic aggregates will replace
older values.

The API should include an `updatedAt` timestamp so clients can
understand how fresh the information is.

------------------------------------------------------------------------

## 23. Privacy and Security

The system should estimate traffic without identifying individual users.

Important measures: 1. Use rotating anonymous device identifiers. 2.
Avoid storing names, phone numbers, or account details with location
events. 3. Encrypt data in transit and at rest. 4. Apply strict access
control. 5. Retain raw location events only for a limited period. 6.
Store aggregated road-level statistics for longer periods. 7. Use
minimum population thresholds before publishing traffic estimates. 8.
Prevent access to individual movement histories. 9. Remove or generalize
data that could identify a person's route. 10. Monitor access to
sensitive location-processing systems.

The system needs to know where devices are moving and how fast they are
moving, not who owns the devices.

------------------------------------------------------------------------

## 24. Monitoring and Reliability

Monitor: - Events received per second. - Invalid or rejected GPS
events. - Kafka consumer lag. - Map-matching success rate. - Traffic
calculation latency. - Percentage of road segments with fresh data. -
Confidence-score distribution. - Database latency and availability. -
API response time and error rate.

Use health checks, alerts, retries, replicated services, and horizontal
scaling. If live processing is delayed, the API can return the last
known estimate with its timestamp and confidence level.

------------------------------------------------------------------------

## 25. Final Interview Explanation

I would design the system using mobile devices as the source of
anonymized GPS and movement events. The API Gateway receives and
validates these events and sends them to Kafka. Kafka provides
high-throughput buffering, partitioning, and replay.

A distributed stream processor consumes the events and performs map
matching to identify the most likely road segment. It groups
observations into short time windows and calculates average speed,
median speed, vehicle count, and speed variance.

The traffic aggregator compares the current speed with the historical
expected speed for that road and time. It also calculates a confidence
score based on the number of independent devices, speed consistency,
observation duration, and GPS accuracy. This is especially important at
3 AM. If only one vehicle reports a low speed, the system marks the
result as low confidence instead of declaring heavy traffic. If many
independent devices consistently report low speeds, the system can
classify the road as congested.

Current traffic information is stored in a low-latency store, while
historical aggregates are stored separately. The routing engine uses
expected travel time rather than distance alone to select the fastest
route. The system uses horizontal scaling, replicated services, eventual
consistency, and privacy controls to support a large number of users.

------------------------------------------------------------------------

## 26. Interview Follow-Up Questions -- Short Answers

### Q1. Why Kafka?

Kafka handles high-volume event ingestion, partitioning, replay,
consumer scaling, and fault tolerance.

### Q2. Why not write every GPS location directly to PostgreSQL?

Millions of writes per second can overload a transactional database.
Kafka and stream processing can aggregate events before storing results.

### Q3. How do you identify the correct road?

Use map matching with GPS accuracy, distance to road geometry, heading,
speed, previous location, and road connectivity.

### Q4. How do you detect an accident?

Detect a sudden speed reduction across multiple independent devices,
compare it with historical speed, and validate that it continues for a
period of time.

### Q5. How do you prevent one slow driver from creating fake traffic?

Use minimum observation counts, unique-device checks, median speed,
outlier filtering, time windows, and a confidence score.

### Q6. What happens if Kafka goes down?

Use broker replication, producer retries, durable storage, consumer
checkpoints, monitoring, and recovery procedures.

### Q7. What consistency model is required?

Eventual consistency is generally sufficient because small delays in
traffic updates are acceptable.

------------------------------------------------------------------------

## 27. Conclusion

The proposed system estimates traffic by combining anonymized
mobile-device movement data, map matching, real-time stream processing,
and historical traffic patterns. A confidence score prevents a small
number of unreliable observations from creating false congestion alerts.
Kafka and distributed processing support high event volumes, while
traffic-aware routing recommends routes based on expected travel time.
Privacy protection, fault tolerance, and low-data handling make the
design suitable for both busy cities and quiet roads at 3 AM.
