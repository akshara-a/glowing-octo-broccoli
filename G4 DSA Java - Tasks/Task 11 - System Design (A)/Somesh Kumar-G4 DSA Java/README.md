# Task 11 - System Design (A)
## Ride Verification + Data Integrity

### Question 1: Foreign Key Behavior

`Rides.user_id` is a foreign key referencing `Users.user_id`. If a user has existing rides, the database normally prevents deleting that user when the foreign key uses restrictive behavior. This protects referential integrity and prevents rides from referring to a non-existing user.
### Question 2: DELETE Strategy

I would prefer `ON DELETE RESTRICT` along with soft deletion or anonymization. `ON DELETE CASCADE` is risky because it can delete important historical rides and payments. `ON DELETE SET NULL` preserves the ride but loses the direct user relationship.

### Question 3: Historical Data

Historical rides and payments should not be deleted when a user deletes their account. They may be required for billing, refunds, disputes, auditing and reporting. The user's personal information can instead be anonymized.

### Question 4: Soft Delete vs Hard Delete

Soft delete is preferable to immediate hard deletion. Using `is_deleted = true` keeps the database record while preventing normal use of the account. Personal information can also be anonymized. This preserves historical relationships but requires additional handling in queries.

### Question 5: Only 10,000 PINs

A 4-digit PIN has only 10,000 possible values, so it cannot be unique for millions of users. Multiple users can have the same PIN. The system distinguishes them using the ride context such as `ride_id`, `captain_id` and `user_id`.

### Question 6: Should ride_pin Be UNIQUE?

No. `ride_pin` should not have a global `UNIQUE` constraint because only 10,000 values are available. Millions of users would require duplicate PINs. The PIN should be used for verification, not as a unique identifier.

### Question 7: PIN Verification

The system should not search only by PIN because multiple users may have the same PIN. Verification should use the active ride, captain and ride status along with the PIN. This ensures that the PIN belongs to the rider of the specific ride being started.

### Question 8: PIN Collision

Duplicate PINs are handled using additional ride information. The backend should verify `ride_id`, `captain_id`, `user_id`, `ride status` and `PIN`. Therefore, the same PIN cannot accidentally start another user's ride.

### Question 9: Where Should the PIN Be Stored?

Storing the PIN on the ride is preferable because each ride can have a temporary PIN. It improves security and allows the PIN to become invalid after the ride. Storing it on the user is simpler but allows PIN reuse. Dynamically generating a PIN provides better security but adds some implementation complexity.

### Question 10: What Indexes Would You Create?

Important indexes should be created on:

- `Users(user_id)`
- `Captains(captain_id)`
- `Rides(ride_id)`
- `Rides(user_id)`
- `Rides(captain_id)`
- `Rides(captain_id, status)`
- `Payments(ride_id)`

A PIN-only index is less useful because many users can have the same PIN.

### Question 11: Primary Key Removal

Normally, a primary key cannot be removed while a foreign key depends on it. The database will usually prevent this operation to protect referential integrity. The dependent foreign key must normally be removed or changed first.

### Question 12: Problems After Removing the Foreign Key

Removing the foreign key and primary key can allow duplicate `user_id` values. This creates ambiguity because a ride containing `user_id = 101` would no longer uniquely identify a user. It can cause incorrect relationships and data-integrity problems.

### Question 13: Concurrency

Concurrent requests to start the same ride should be controlled using transactions, row-level locking, atomic updates or optimistic locking. These mechanisms ensure that only one request can successfully change the ride from `WAITING` to `STARTED`.

### Question 14: Atomic Ride Start

An atomic update is safer because it checks the ride status and updates it in one database operation. If the affected row count is `1`, the ride was successfully started. If it is `0`, the ride was already started or the request was invalid. This prevents race conditions.

### Question 15: PIN Guessing

Since there are only 10,000 possible PINs, the system should use rate limiting, maximum attempt limits, temporary lockouts and audit logs. Captain and device information can also be monitored to detect suspicious repeated attempts.

# Final Architecture

The rider books a ride and the system creates a ride record. A captain is assigned and the ride enters the waiting state. When the captain reaches the pickup point, the rider provides the PIN.

The captain sends the `ride_id`, `captain_id` and PIN to the backend. The backend verifies the ride, captain, rider, ride status and PIN.

If all details are valid, the system atomically changes the ride status from `WAITING` to `STARTED`. Otherwise, the request is rejected.

Duplicate PINs are allowed because the PIN is not used as a unique identifier. The ride context identifies the correct rider and ride.

Foreign keys maintain relationships between users, rides and payments. Historical rides and payments are retained when a user deletes their account, while personal information can be soft-deleted or anonymized.

Indexes improve query performance, atomic updates handle concurrent requests, and rate limiting prevents PIN brute-force attacks.

Overall, the design maintains **data integrity, security, scalability and consistency** while supporting millions of users with only 10,000 possible PIN values.