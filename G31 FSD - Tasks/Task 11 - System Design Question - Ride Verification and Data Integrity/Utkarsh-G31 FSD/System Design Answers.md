# System Design: Ride Verification + Data Integrity

## Q1. Foreign Key Behavior

`Rides.user_id` is a foreign key referring to `Users.user_id`. If we try to delete User 101 while Ride 5001 still exists, the database will normally reject it. This prevents a ride from referring to a user that does not exist.

## Q2. DELETE Strategy

I would use `ON DELETE RESTRICT`. We should not delete rides when a user deletes their account because rides and payments are historical records. `CASCADE` could delete this data, while `SET NULL` would remove the user reference. Soft delete or anonymization is a better option.

## Q3. Historical Data

No, historical rides and payments should not be deleted. They may be needed for transaction history, refunds, reports, and other records. The user's personal information can be deleted or anonymized instead.

## Q4. Soft Delete vs Hard Delete

I would prefer soft delete or anonymization. We can set `is_deleted = true` and remove or anonymize information like name, phone, and email. This keeps the user record so old rides can still refer to it.

## Q5. Only 10,000 PINs

There are only 10,000 possible PINs, so millions of users cannot have unique PINs. Multiple users can have the same PIN. The system should use the PIN along with `ride_id`, `captain_id`, and other ride details to identify the correct ride.

## Q6. Should `ride_pin` Be UNIQUE?

No, `ride_pin` should not be unique. There are only 10,000 possible values, so a unique constraint would not work for millions of users. The PIN should be used as a verification code, not as a unique identifier.

## Q7. PIN Verification

We should not search the whole `Users` table using only the PIN because multiple users can have the same PIN. Instead, the backend should check the PIN together with `ride_id`, `captain_id`, and `status = 'WAITING'`. This makes sure the PIN is checked only for the correct active ride.

## Q8. PIN Collision

If User A and User B both have `4821`, there is no problem because the PIN is not used alone. The system should also check the `ride_id`, `captain_id`, `user_id`, and ride status. This ensures that the PIN only works for the correct ride.

## Q9. PIN Storage Strategy

I would store the PIN on the `Rides` table and generate a new PIN for each ride. This makes the PIN valid only for that particular ride and provides better security. Dynamic generation can also be used, but it adds some extra complexity.

## Q10. What Indexes Would You Create?

I would create indexes on `Rides(user_id)`, `Rides(captain_id)`, `Rides(captain_id, status)`, and `Payments(ride_id)`. The primary keys `user_id` and `ride_id` are normally indexed automatically. `ride_pin` does not need to be unique, but it can be indexed if the system needs to search by it.

## Q11. Primary Key Removal

Normally, a primary key cannot be removed while a foreign key depends on it. The database will usually reject the operation because `Rides.user_id` references `Users.user_id`. This protects the relationship between the tables.

## Q12. Removing the Foreign Key and Primary Key

If we remove the foreign key and then the primary key, multiple users could have the same `user_id`. For example, `101` could belong to Ravi, Amit, and John. A ride with `user_id = 101` would then have no way to know which user it belongs to, causing inconsistent data.

## Q13. Concurrency

Two requests may try to start the same ride at the same time. I would use a transaction with row-level locking or an atomic update. Only one request should be allowed to change the ride from `WAITING` to `STARTED`.

## Q14. Atomic Ride Start

Yes, an atomic update is safer:

```sql
UPDATE rides
SET status = 'STARTED'
WHERE ride_id = ?
  AND captain_id = ?
  AND status = 'WAITING';
```

If one row is affected, the ride started successfully. If zero rows are affected, the ride was already started or the details were incorrect. This avoids the problem that can happen when `SELECT` and `UPDATE` are done separately.

## Q15. PIN Guessing

Since there are only 10,000 possible PINs, the system should prevent repeated attempts.

I would use rate limiting and set a maximum number of attempts for a ride or captain.

After too many wrong attempts, the PIN verification can be temporarily locked. We should also keep audit logs of failed attempts and track the captain or device making the requests.

This makes it much harder to guess the PIN by trying all possible combinations.

## Final Architecture

The complete flow would be:

### 1. Ride Booking

The rider books a ride and a new ride record is created with:

- `ride_id`
- `user_id`
- `captain_id`
- `status`
- ride-specific PIN

The PIN does not have to be unique because there are only 10,000 possible PINs.

### 2. Captain Assignment

A captain is assigned to the ride and the ride remains in `WAITING` status.

The system can use indexes such as `Rides(captain_id, status)` to quickly find the captain's active ride.

### 3. PIN Verification

When the captain reaches the pickup location, the rider provides the PIN.

The captain sends the PIN along with the ride information to the backend.

The backend checks:

- `ride_id`
- `captain_id`
- `user_id`
- `status = 'WAITING'`
- PIN

The PIN is checked only for that specific ride, so duplicate PINs do not cause a problem.

### 4. Start the Ride

If all the details are correct, the backend performs an atomic update:

```sql
UPDATE rides
SET status = 'STARTED'
WHERE ride_id = ?
  AND captain_id = ?
  AND status = 'WAITING';
```

If one row is affected, the ride is started.

If no row is affected, the request is rejected because the ride may already be started or the details may be incorrect.

### 5. Concurrency

If two requests try to start the same ride at the same time, the atomic update ensures that only one request can change the status from `WAITING` to `STARTED`.

The second request will fail because the status is no longer `WAITING`.

### 6. PIN Security

Since a 4-digit PIN has only 10,000 possibilities, the system should use:

- Rate limiting
- Maximum attempts
- Temporary lockout
- Audit logs
- Captain/device tracking

This prevents repeated PIN guessing.

### 7. User Deletion and Historical Data

If a user deletes their account, I would use soft delete or anonymization instead of deleting the user record directly.

Rides and payments should remain because they are historical records.

Foreign keys should also be maintained so that the relationships between users, rides, and payments remain valid.

### Overall Flow

```text
Rider books ride
        ↓
Ride + PIN created
        ↓
Captain assigned
        ↓
Captain reaches pickup
        ↓
Rider provides PIN
        ↓
Backend checks ride + captain + user + status + PIN
        ↓
      Valid?
     /      \
   Yes       No
    ↓         ↓
START       Reject
RIDE        request
    ↓
Payment and ride history remain consistent
```
