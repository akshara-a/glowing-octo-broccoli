System Design Question: Ride Verification + Data Integrity

Question 1: Foreign Key Behavior

Rides.user_id is a foreign key referencing Users.user_id.

If we execute:

DELETE FROM users
WHERE user_id = 101;

while rides belonging to user 101 still exist, the deletion will normally be rejected if the foreign key uses the default/restrict behavior.

The foreign key protects database integrity by ensuring that every non-null Rides.user_id refers to an existing Users.user_id. This prevents orphan ride records.

For example, the database should not allow:

Rides
ride_id | user_id
5001    | 999

if user 999 does not exist.

Question 2: DELETE Strategy

I would choose ON DELETE RESTRICT for the relationship between Users and Rides.

FOREIGN KEY (user_id)
REFERENCES Users(user_id)
ON DELETE RESTRICT

The reason is that rides are important historical records. Automatically deleting a user should not automatically delete all their rides.

ON DELETE CASCADE could delete historical rides, which may also affect related payment records.

ON DELETE SET NULL would preserve the ride, but it would remove the direct user relationship. It can be useful in some designs, but for this system I would prefer keeping the relationship and using soft deletion/anonymization for the user.

Question 3: Historical Data

Historical rides and payments should not disappear when a user deletes their account.

For example:

User 101
   ↓
Ride 5001
   ↓
Payment 9001

After account deletion, the ride and payment records should remain.

They may be required for:

Ride history

Payment and accounting records

Refunds and disputes

Auditing

Data consistency

Business reporting

Deleting historical rides and payments could make the system lose important information.

Question 4: Soft Delete vs Hard Delete

I would prefer soft deletion combined with anonymization.

For example:

user_id    = 101
name       = NULL
phone      = NULL
email      = NULL
is_deleted = true

The important historical relationships can remain while personal information is removed or anonymized according to the application's data-retention requirements.

Advantages

Historical rides remain available.

Payment records remain consistent.

Auditing and accounting are easier.

The original user_id can continue to identify the historical account record.

Personal information can be removed from active use.

Disadvantages

The database retains the user record.

Queries must correctly handle is_deleted.

Storage is not immediately reclaimed.

Anonymization and retention policies must be managed carefully.

Ride PIN Design

Question 5: Only 10,000 PINs

A 4-digit PIN has only:

10,000 possible values

Therefore, it is impossible for 10 million users to each have a globally unique 4-digit PIN.

Multiple users can have the same PIN.

For example:

User A → 4821
User B → 4821
User C → 7390

This is not a problem because the PIN is not the unique identifier of the ride.

The system should use the ride context, such as:

ride_id
captain_id
user_id
status
PIN

to identify and verify the correct ride.

Question 6: Should ride_pin Be UNIQUE?

No.

I would not use:

ride_pin VARCHAR(4) UNIQUE

because there are only 10,000 possible PINs, while the system may have millions of users or rides.

A unique constraint would eventually prevent users/rides from using an already-used PIN.

Duplicate PINs are expected.

The unique identifier should be ride_id, not the PIN.

Question 7: PIN Verification

I would not verify a PIN using only:

SELECT *
FROM users
WHERE ride_pin = '4821';

This is unsafe because many users can have the same PIN.

The query could return multiple users, creating ambiguity.

Instead, the backend should use the active ride context:

SELECT r.*
FROM rides r
JOIN users u
    ON r.user_id = u.user_id
WHERE r.ride_id = ?
  AND r.captain_id = ?
  AND r.status = 'WAITING'
  AND u.ride_pin = ?;

If the PIN is stored on Rides, the design can be even simpler:

SELECT ride_id
FROM rides
WHERE ride_id = ?
  AND captain_id = ?
  AND status = 'WAITING'
  AND ride_pin = ?;

This is safer because the PIN is checked against the specific ride, rather than searching all users with that PIN.

Question 8: PIN Collision

Suppose:

User A → PIN 4821
User B → PIN 4821

The system does not identify a ride using 4821 alone.

Instead, the captain's request contains the specific ride context.

The backend checks:

ride_id
+
captain_id
+
ride status
+
PIN

For example:

Ride 5001
User 101
Captain 201
PIN 4821
Status WAITING

The captain assigned to ride 5001 enters 4821.

Only if the captain, ride, status, and PIN all match is the ride allowed to start.

Therefore, another user having the same PIN does not cause their ride to start.

PIN Storage Strategy

Question 9: Where Should the PIN Be Stored?

Option A: PIN Stored on User

Users
-----
user_id
ride_pin

Advantages:

Simple.

A user can reuse the same PIN across rides.

Less ride-level data.

Disadvantages:

The same PIN is reused for multiple rides.

If the PIN is exposed, it may be less secure for future rides.

It does not naturally represent a specific ride verification secret.

Option B: PIN Stored on Ride

Rides
-----
ride_id
user_id
captain_id
ride_pin
status

This is my preferred design.

A new PIN can be generated for each ride:

Ride 1 → 4821
Ride 2 → 7390
Ride 3 → 1054

Advantages:

PIN is tied directly to the ride.

Better isolation between rides.

A compromised PIN does not automatically affect future rides.

Verification becomes straightforward.

Duplicate PINs are still allowed because ride_id is unique.

Option C: Generate PIN Dynamically

A temporary PIN can be generated when the captain approaches the pickup location.

Advantages:

Better security.

PIN can have a short validity period.

Less opportunity for long-term PIN reuse.

Disadvantages:

More implementation complexity.

Requires reliable state management.

The user experience must handle PIN generation and delivery correctly.

The generated PIN still does not need to be globally unique.

Choice

For this system, I would choose Option B: store a generated PIN on the ride.

It provides a good balance of simplicity, security, and ride-level verification.

Indexing

Question 10: What Indexes Would You Create?

Primary keys normally create indexes automatically.

Therefore:

Users(user_id)
Rides(ride_id)

are indexed through their primary keys.

I would also create indexes based on common queries:

Rides(user_id)
Rides(captain_id)
Rides(captain_id, status)
Payments(ride_id)

Why?

Rides(user_id):

Used to find a user's rides.

Rides(captain_id):

Used to find rides assigned to a captain.

Rides(captain_id, status):

Useful for queries such as finding a captain's active/waiting ride.

Payments(ride_id):

Useful for finding payment information associated with a ride.

Should ride_pin be indexed?

I would not make ride_pin a standalone primary/unique index.

Since the PIN is only one part of ride verification, the main lookup should use the specific ride_id and captain context.

If the application had a query that frequently searched by PIN as part of a larger lookup, an appropriate composite index could be considered based on the actual query workload.

Indexes should be created according to query patterns because every additional index also adds storage and write/update overhead.

Primary Key Removal

Question 11

Normally, a primary key cannot simply be removed while a foreign key depends on it.

The foreign key requires the referenced column to provide a unique candidate key.

Most relational databases will reject the operation or require the dependent foreign key constraint to be removed/changed first.

This protects the referential integrity of the database.

Question 12

If we first remove the foreign key:

ALTER TABLE rides
DROP FOREIGN KEY fk_rides_user;

and then remove the primary key:

ALTER TABLE users
DROP PRIMARY KEY;

the database loses important integrity protection.

Without the primary key, duplicate user_id values could potentially be inserted if there is no other unique constraint.

For example:

Users

user_id | name
--------|------
101     | Ravi
101     | Amit
101     | John

Now this ride:

Rides

ride_id | user_id
--------|--------
5001    | 101

is ambiguous.

Which user does 101 represent?

It could refer to Ravi, Amit, or John.

The database can no longer guarantee that user_id uniquely identifies one user.

This demonstrates why primary keys and foreign keys are essential for relational data integrity.

Advanced Questions

Question 13: Concurrency

Two requests may arrive at almost the same time:

Captain Device 1 → Start Ride 5001
Captain Device 2 → Start Ride 5001

Both requests could initially see the ride as WAITING.

To prevent both from starting the ride, I would use a transaction and an atomic state transition.

A row-level lock can also be used when appropriate.

An atomic update is particularly useful:

UPDATE rides
SET status = 'STARTED'
WHERE ride_id = ?
  AND captain_id = ?
  AND status = 'WAITING';

Then check the affected rows.

Only one request should successfully change the row from WAITING to STARTED.

Question 14: Atomic Ride Start

Yes, this is safer:

UPDATE rides
SET status = 'STARTED'
WHERE ride_id = ?
  AND captain_id = ?
  AND status = 'WAITING';

Then:

affected rows = 1 → success
affected rows = 0 → reject/already started/invalid request

This is safer than:

SELECT ride
      ↓
check status
      ↓
UPDATE ride

because the separate SELECT and UPDATE can create a race condition.

Two requests might both read:

status = WAITING

before either update occurs.

The conditional update performs the check and state change as one atomic database operation.

The PIN verification can also be included in the condition:

UPDATE rides
SET status = 'STARTED'
WHERE ride_id = ?
  AND captain_id = ?
  AND status = 'WAITING'
  AND ride_pin = ?;

Question 15: PIN Guessing

A 4-digit PIN has only 10,000 possible combinations, so unlimited attempts would be insecure.

I would use:

Rate limiting

Maximum failed attempts

Temporary lockout

Captain identity tracking

Device/session tracking

Audit logs

Monitoring for repeated failures

For example, after several incorrect attempts, the verification endpoint could temporarily block further attempts for that captain/device/ride.

This makes brute-force attacks much harder.

Final Architecture

Ride Booking

Rider books ride
        ↓
Ride record created
        ↓
Unique ride_id generated
        ↓
4-digit PIN generated
        ↓
PIN stored with the ride
        ↓
Captain assigned
        ↓
Ride status = WAITING

Ride Verification

When the captain reaches the pickup point:

Rider provides PIN
        ↓
Captain enters PIN
        ↓
Backend receives:
    ride_id
    captain_id
    PIN
        ↓
Verify:
    ride exists
    captain is assigned
    status = WAITING
    PIN matches ride PIN
        ↓
      Valid?
     /      \
   Yes       No
    ↓         ↓
STARTED     REJECT

The ride start can be performed atomically:

UPDATE rides
SET status = 'STARTED'
WHERE ride_id = ?
  AND captain_id = ?
  AND status = 'WAITING'
  AND ride_pin = ?;

If:

affected rows = 1

the ride successfully starts.

If:

affected rows = 0

the request is rejected or the ride has already changed state.

How the Design Handles the Requirements

Millions of users

The system does not require globally unique 4-digit PINs.

user_id and ride_id remain the unique identifiers.

Only 10,000 PIN values

Multiple users and rides can safely share the same PIN.

The PIN is only one verification factor, not the unique identity of a ride.

Duplicate PINs

Duplicate PINs are allowed because verification uses the specific ride and captain context.

Foreign Keys

Foreign keys maintain relationships between:

Users → Rides
Rides → Payments
Rides → Captains

They prevent invalid references and orphan records.

User deletion

I would prefer soft deletion/anonymization rather than cascading deletion of historical rides.

Historical rides and payments remain available for appropriate business, accounting, audit, and dispute purposes.

Historical rides and payments

Historical records should remain consistent and should not be automatically deleted just because the user account is deactivated.

Indexes

Use primary-key indexes plus indexes based on common query patterns, such as:

Rides(user_id)
Rides(captain_id)
Rides(captain_id, status)
Payments(ride_id)

Concurrency

Use an atomic conditional update and, where necessary, transactions/row-level locking.

Only one request should be able to transition a ride from:

WAITING → STARTED

successfully.

PIN brute-force attempts

Use rate limiting, maximum attempts, temporary lockouts, captain/device tracking, and audit logs.

Primary-key removal

A primary key provides uniqueness and is required for the normal foreign-key relationship.

Removing the foreign key and primary key can allow duplicate IDs and create ambiguous references.

Overall data integrity

The design combines:

Primary Keys
+
Foreign Keys
+
Ride-level PIN
+
Ride/captain validation
+
Status validation
+
Atomic updates
+
Indexes
+
Deletion/anonymization policy
+
Rate limiting

This ensures that a 4-digit PIN does not need to be globally unique while still ensuring that only the correct captain can start the correct active ride.