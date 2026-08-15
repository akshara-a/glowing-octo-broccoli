# Ride Verification and Data Integrity

### Question 1: Foreign Key Behavior

If a user is deleted while their rides still exist, the database will normally reject the deletion because `Rides.user_id` references `Users.user_id`. This prevents orphan ride records and maintains data integrity.

### Question 2: DELETE Strategy

I would use **ON DELETE RESTRICT** for `Users → Rides`. It prevents accidental deletion of rides and protects important historical data such as payments and ride records.

### Question 3: Historical Data

Historical rides and payments should normally be retained even if a user deletes their account. They may be needed for refunds, disputes, accounting, and customer support. Soft deletion or anonymization can be used for the user's personal information.

### Question 4: Soft Delete vs Hard Delete

**Soft delete** is preferable because it keeps historical relationships intact. For example, the user's account can be marked as deleted instead of physically removing the record.

### Question 5: Only 10,000 PINs

A 4-digit PIN has only **10,000 possible values (0000–9999)**. Therefore, PINs cannot be globally unique when there are millions of users. Duplicate PINs are allowed.

### Question 6: Should `ride_pin` Be UNIQUE?

No. `ride_pin` should normally **not** have a `UNIQUE` constraint because the same PIN can be used by different rides. The complete ride context should identify the correct ride.

### Question 7: PIN Verification

The system should not search using the PIN alone. It should verify the **ride ID, captain ID, ride status, and PIN** together to identify the correct active ride.

### Question 8: PIN Collision

Two users can have the same PIN. This does not cause a problem because the system uses the **ride ID and captain information** along with the PIN to identify the correct ride.

### Question 9: Where Should the PIN Be Stored?

The PIN should preferably be stored in the **Rides table**. This allows each ride to have its own temporary PIN, which improves security and allows the PIN to expire when the ride ends.

### Question 10: Indexes

Useful indexes include:

* `Users(user_id)`
* `Rides(ride_id)`
* `Rides(user_id)`
* `Rides(captain_id)`
* `Rides(captain_id, status)`
* `Payments(ride_id)`

These indexes help the system find rides and payment information faster.

### Question 11: Can the Primary Key Be Removed?

A primary key should not be removed while a foreign key depends on it. The foreign key relationship must be removed or changed first to avoid breaking database integrity.

### Question 12: Data Integrity After Removing the Foreign Key

Without a primary key and foreign key, duplicate `user_id` values could occur. This can cause incorrect users, rides, payments, and database relationships.

### Question 13: Concurrency

If two captains try to start the same ride at the same time, the system should use **transactions, locking, or atomic updates** to ensure that only one request starts the ride.

### Question 14: Atomic Ride Start

An atomic update can safely start a ride:

```sql
UPDATE rides
SET status = 'STARTED'
WHERE ride_id = ?
  AND captain_id = ?
  AND status = 'WAITING';
```

If one row is affected, the ride starts successfully. Otherwise, it was already started or the conditions were incorrect.

### Question 15: PIN Guessing

Since there are only 10,000 PINs, the system should use **rate limiting, maximum attempts, temporary lockouts, audit logs, captain authentication, and ride validation** to prevent PIN guessing attacks.

## Conclusion

The system should use primary keys, foreign keys, proper indexes, soft deletion, ride-level PINs, atomic updates, and security controls to maintain data integrity and safely verify rides.
