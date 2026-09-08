# System Design: Ride Verification + Data Integrity

## Q1. Foreign Key Behavior

`Rides.user_id` is a foreign key referencing `Users.user_id`. Deleting User 101 while Ride 5001 exists will normally be rejected. This prevents a ride from referencing a non-existent user.

## Q2. DELETE Strategy

Use `ON DELETE RESTRICT`. Rides and payments are historical records and should not be deleted when a user deletes their account. Soft delete or anonymization is preferred.

## Q3. Historical Data

No, historical rides and payments should not be deleted. They may be required for transaction history, refunds, reports, and other records. Personal information can instead be deleted or anonymized.

## Q4. Soft Delete vs Hard Delete

Prefer soft delete or anonymization. Set `is_deleted = true` and remove or anonymize information such as name, phone, and email while keeping the user record for historical references.

## Q5. Only 10,000 PINs

A 4-digit PIN has only 10,000 possible values (`0000–9999`), so millions of users cannot have unique PINs. Multiple users can have the same PIN. The PIN must be combined with `ride_id`, `captain_id`, and other ride details.

## Q6. Should `ride_pin` Be UNIQUE?

No. `ride_pin` should not be unique because there are only 10,000 possible values. It should be used as a verification code, not as a unique identifier.

## Q7. PIN Verification

Do not search the entire `Users` table using only the PIN. Check the PIN together with:

* `ride_id`
* `captain_id`
* `user_id`
* `status = 'WAITING'`

This ensures the PIN is checked only for the correct active ride.

## Q8. PIN Collision

If User A and User B both have `4821`, there is no problem because the PIN is not used alone. The system also checks the ride and captain details, ensuring the PIN works only for the correct ride.

## Q9. PIN Storage Strategy

Store the PIN in the `Rides` table and generate a new PIN for each ride. This makes the PIN specific to that ride and improves security.

## Q10. Indexes

Useful indexes include:

* `Rides(user_id)`
* `Rides(captain_id)`
* `Rides(captain_id, status)`
* `Payments(ride_id)`

Primary keys such as `user_id` and `ride_id` are normally indexed automatically. `ride_pin` can be indexed if searching by PIN is required, but it should not be unique.

## Q11. Primary Key Removal

A primary key normally cannot be removed while a foreign key depends on it. The database will reject the operation because `Rides.user_id` references `Users.user_id`.

## Q12. Removing the Foreign Key and Primary Key

If both constraints are removed, multiple users could have the same `user_id`. For example, `101` could belong to Ravi, Amit, and John. A ride with `user_id = 101` would then be ambiguous, causing inconsistent data.

## Q13. Concurrency

Two requests may try to start the same ride simultaneously. Use a transaction with row-level locking or an atomic update so that only one request can change the ride from `WAITING` to `STARTED`.

## Q14. Atomic Ride Start

```sql
UPDATE rides
SET status = 'STARTED'
WHERE ride_id = ?
  AND captain_id = ?
  AND status = 'WAITING';
```

If one row is affected, the ride started successfully.

If zero rows are affected, the ride was already started or the details were incorrect.

This is safer than performing separate `SELECT` and `UPDATE` operations.

## Q15. PIN Guessing

Because there are only 10,000 possible PINs, repeated attempts must be restricted.

Use:

* Rate limiting
* Maximum attempts per ride/captain
* Temporary lockout
* Audit logs
* Captain/device tracking

This prevents attackers from repeatedly guessing PINs.

# Final Architecture

## 1. Ride Booking

Create a ride record containing:

* `ride_id`
* `user_id`
* `captain_id`
* `status`
* Ride-specific PIN

The PIN does not need to be unique.

## 2. Captain Assignment

Assign a captain to the ride and keep the ride in `WAITING` status.

Use indexes such as `Rides(captain_id, status)` to quickly find active rides.

## 3. PIN Verification

When the captain reaches the pickup location, the rider provides the PIN.

The backend checks:

* `ride_id`
* `captain_id`
* `user_id`
* `status = 'WAITING'`
* PIN

Duplicate PINs therefore do not cause a problem.

## 4. Start the Ride

If all details are correct, perform the atomic update:

```sql
UPDATE rides
SET status = 'STARTED'
WHERE ride_id = ?
  AND captain_id = ?
  AND status = 'WAITING';
```

One affected row → ride started.

Zero affected rows → request rejected.

## 5. Concurrency

If two requests try to start the same ride simultaneously, only one can change the status from `WAITING` to `STARTED`.

The second request fails because the status is no longer `WAITING`.

## 6. PIN Security

Since a 4-digit PIN has only 10,000 possibilities, use:

* Rate limiting
* Maximum attempts
* Temporary lockout
* Audit logs
* Captain/device tracking

## 7. User Deletion and Historical Data

Use soft delete or anonymization instead of directly deleting the user record.

Rides and payments should remain as historical records, while foreign-key relationships should remain valid.

# Overall Flow

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
Backend checks:
ride + captain + user + status + PIN
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
