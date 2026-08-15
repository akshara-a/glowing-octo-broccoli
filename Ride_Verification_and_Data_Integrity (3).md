# Ride Verification and Data Integrity

## Question 1: Foreign Key Behavior

If a user is deleted while rides belonging to that user still exist, the database will normally reject the deletion when the foreign key uses restrictive behavior. This prevents orphan records and maintains referential integrity.

## Question 2: DELETE Strategy

I would use `ON DELETE RESTRICT` for `Users -> Rides`. It prevents accidental deletion of historical rides and payments. The preferred practical approach is **RESTRICT + soft deletion/anonymization**.

## Question 3: Historical Data

Historical rides and payments should normally be retained after account deletion, subject to applicable retention and privacy requirements. They may be needed for refunds, disputes, accounting, fraud investigation, auditing and customer support.

## Question 4: Soft Delete vs Hard Delete

Soft deletion is preferable to physical deletion because it keeps historical relationships intact.

```sql
UPDATE Users
SET is_deleted = TRUE
WHERE user_id = 101;
```

Personal information can also be anonymized when appropriate.

## Question 5: Only 10,000 PINs

A 4-digit PIN has only 10,000 possible values (`0000-9999`). Therefore, PINs cannot be globally unique for millions of users. Duplicate PINs are allowed.

```text
User A -> 4821
User B -> 4821
User C -> 7390
```

A PIN is a **credential**, not a unique identifier. `user_id` and `ride_id` provide unique identity.

## Question 6: Should `ride_pin` Be UNIQUE?

No. `ride_pin` should not have a `UNIQUE` constraint because only 10,000 PIN values exist. Millions of rides or users will necessarily contain duplicate PINs. The system should use `ride_id` and the ride context to identify the correct ride.

## Question 7: PIN Verification

The system should not search using the PIN alone because duplicate PINs can match multiple users or rides.

```sql
SELECT r.*
FROM Rides r
WHERE r.ride_id = ?
  AND r.captain_id = ?
  AND r.status = 'WAITING'
  AND r.ride_pin = ?;
```

This verifies the exact ride, assigned captain, active state and PIN. In production, the PIN should preferably be stored as a secure hash.

## Question 8: PIN Collision

Two users can have the same PIN without causing a problem. The backend uses `ride_id`, `captain_id`, ride status and PIN together. Therefore, the PIN does not identify the ride by itself.

## Question 9: Where Should the PIN Be Stored?

The preferred design is a **ride-specific PIN** stored with the Ride record, preferably as a secure hash. This allows every ride to have a temporary PIN that can expire when the ride ends.

```text
Ride 5001 -> PIN 4821
Ride 5002 -> PIN 7390
```

A dynamic PIN generated near pickup can improve security further, but adds complexity for expiration, synchronization and recovery.

## Question 10: Indexes

Useful indexes include:

```text
Users(user_id)
Rides(ride_id)
Rides(user_id)
Rides(captain_id)
Rides(captain_id, status)
Payments(payment_id)
Payments(ride_id)
```

These indexes speed up common lookups. A PIN should not be the main authorization lookup because the ride context is more important.

## Question 11: Can the Primary Key Be Removed?

Normally, a database will not allow a referenced primary key to be removed while a foreign key depends on it, unless the dependency is removed or another suitable unique referenced key is established. The primary key guarantees that each `user_id` identifies one user.

## Question 12: Data Integrity After Removing the Foreign Key

If the foreign key and primary key are removed, duplicate `user_id` values could occur:

```text
user_id | name
--------|------
101     | Ravi
101     | Amit
101     | John
```

A ride containing `user_id = 101` would then be ambiguous because the database could not determine which user is represented by 101. This demonstrates the importance of primary and foreign keys.

## Question 13: Concurrency

If two requests try to start the same ride at the same time, a simple `SELECT` followed by `UPDATE` can create a race condition. The system should use transactions, appropriate row-level locking, atomic updates, or optimistic locking/version numbers.

## Question 14: Atomic Ride Start

Use an atomic state transition:

```sql
UPDATE Rides
SET status = 'STARTED'
WHERE ride_id = ?
  AND captain_id = ?
  AND status = 'WAITING';
```

If `affected rows = 1`, the ride was successfully started. If `affected rows = 0`, the ride was already started or the conditions were invalid. This is safer than an unprotected `SELECT` followed by `UPDATE`.

## Question 15: PIN Guessing

Because there are only 10,000 PINs, unrestricted guessing must be prevented. Use rate limiting, maximum failed attempts, temporary lockouts, captain authentication, device/session monitoring, audit logs and suspicious-activity detection.

## Final Architecture

```text
Rider books ride
        |
        v
Create Ride
        |
        v
Assign Captain
        |
        v
Generate ride-specific PIN
        |
        v
Captain reaches pickup
        |
        v
Rider provides PIN
        |
        v
Captain sends ride_id + captain_id + PIN
        |
        v
Backend verifies:
    - Ride exists
    - Captain is assigned
    - Status = WAITING
    - PIN matches
        |
    +---+---+
    |       |
  VALID   INVALID
    |       |
    v       v
 Atomic   Reject
 UPDATE   request
    |
    v
 STARTED
```

## Recommended Database Design

```text
Users
-------------------------
user_id        PK
name
phone
is_deleted
deleted_at

Captains
-------------------------
captain_id     PK
name
vehicle_id

Rides
-------------------------
ride_id        PK
user_id        FK
captain_id     FK
ride_pin_hash
status
created_at
started_at
completed_at

Payments
-------------------------
payment_id     PK
ride_id        FK
amount
status
created_at
```

## Conclusion

The system should not make the 4-digit PIN unique because only 10,000 PIN values exist. Multiple users and rides can safely share the same PIN.

The PIN is a credential, while `ride_id` is the unique ride identifier. The backend should verify:

```text
ride_id + captain_id + ride status + PIN
```

Historical rides and payments should normally be retained, while users can be soft-deleted and personal information anonymized.

Foreign keys, primary keys, indexes, atomic updates, rate limiting and audit logs maintain data integrity, performance and security.
