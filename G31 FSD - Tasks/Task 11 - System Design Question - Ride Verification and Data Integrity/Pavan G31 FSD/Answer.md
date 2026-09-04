
## Q1. Foreign Key BehaviorQuestion

Rides.user_id is a foreign key referring to Users.user_id. If we try to delete User 101 while Ride 5001 still exists, what happens?

## Explain how the foreign key protects database integrity.

## Answer

Rides.user_id is a foreign key that references the primary key Users.user_id.

If User 101 has an existing ride, such as Ride 5001, the database will normally reject:

```sql
DELETE FROM users
WHERE user_id = 101;
```

because Rides.user_id still references Users.user_id = 101.

This prevents an orphan ride from being created where a ride refers to a user that no longer exists.

Therefore, the foreign key maintains referential integrity between the Users and Rides tables.

The exact behavior depends on the configured ON DELETE rule, such as:

```sql
ON DELETE RESTRICT
ON DELETE CASCADE
ON DELETE SET NULL
```

## Q2. DELETE Strategy

## Which strategy would you use between:

```sql
ON DELETE CASCADE
ON DELETE SET NULL

or:

ON DELETE RESTRICT
```

ON DELETE CASCADE could delete the user's historical rides, which is not desirable.

ON DELETE SET NULL would preserve the ride but remove its reference to the user, which may also affect historical data integrity.

Therefore, I would use ON DELETE RESTRICT and handle user deletion through soft delete or anonymization.

## Q3. Historical Data

Should historical rides disappear when a user deletes their account?

## Answer

No, historical rides and payments should not be deleted when a user deletes their account.

The ride and payment records may be required for:

Transaction history
Refunds
Payment reconciliation
Reports
Auditing
Business and legal requirements

Instead of deleting the historical records, the user's personal information can be deleted or anonymized according to the application's data-retention policy.

## Q4. Soft Delete vs Hard Delete

Would you physically delete the user:

```sql
DELETE FROM users
WHERE user_id = 101;
```

Or use a soft-delete strategy such as:

is_deleted = true

## Answer

I would prefer soft delete combined with anonymization, depending on the application's data-retention requirements.

```sql
user_id = 101
name = NULL
phone = NULL
email = NULL
is_deleted = true
```

This approach allows the system to preserve the user's database record so that historical rides and payments can continue to reference it.

## Q5. Only 10,000 PINs

A 4-digit PIN has only:

0000–9999

Therefore, there are only:

10,000 possible PINs

But assume the system has:

10,000,000 users

## Answer

A 4-digit PIN has only 10,000 possible values, so it is impossible to assign a globally unique PIN to 10 million users.

Therefore, multiple users can have the same PIN.

For example:

User A → PIN 4821
User B → PIN 4821
User C → PIN 7390

This is acceptable because the PIN should not be treated as a unique identifier.

The system should distinguish users and rides using additional information such as:

```sql
ride_id
captain_id
user_id
ride status
ride_pin

For example:

SELECT r.*
FROM rides r
JOIN users u
    ON r.user_id = u.user_id
WHERE r.ride_id = ?
  AND r.captain_id = ?
  AND r.status = 'WAITING'
  AND u.ride_pin = ?;
```

Thus, even if multiple users have the same PIN, the backend verifies the PIN within the context of the specific active ride.

## Q6. Should ride_pin Be UNIQUE?

Should this column have a unique constraint?

## ride_pin VARCHAR(4) UNIQUE

Explain why this would or would not work for millions of users.

## Answer

No, ride_pin should not have a UNIQUE constraint.

A 4-digit PIN has only:

10,000 possible values

but the system may have millions of users. Therefore, multiple users must be allowed to have the same PIN.

## Q7. PIN Verification

Suppose a captain enters:

## 4821

Should the system execute:

```sql
SELECT *
FROM users
WHERE ride_pin = '4821';
```

## Answer

No, the system should not search only by the PIN:

```sql
SELECT *
FROM users
WHERE ride_pin = '4821';
```

This can return multiple users because duplicate PINs are allowed.

The backend would not know which user or ride the captain is trying to start.

Instead, the system should verify the PIN using the active ride context:

```sql
SELECT r.*
FROM rides r
JOIN users u
    ON r.user_id = u.user_id
WHERE r.ride_id = ?
  AND r.captain_id = ?
  AND r.status = 'WAITING'
  AND u.ride_pin = ?;
```

## This ensures that:

The correct ride is being verified.
The correct captain is attempting to start the ride.
The ride is still in WAITING status.
The PIN belongs to the rider of that ride.

## Q8. PIN Collision

starts the correct ride?

What additional context should be checked?

Consider:

```sql
ride_id
captain_id
user_id
ride status
PIN
```

## Answer

The system should not use the PIN alone to identify the ride.

The backend should verify the PIN together with the specific ride context:

```sql
ride_id
captain_id
user_id
ride status
PIN

## For example:

SELECT r.*
FROM rides r
JOIN users u
    ON r.user_id = u.user_id
WHERE r.ride_id = ?
  AND r.captain_id = ?
  AND r.status = 'WAITING'
  AND u.ride_pin = ?;
```

If both User A and User B have the same PIN:

User A → 4821 → Ride 5001
User B → 4821 → Ride 5002

the captain assigned to Ride 5001 can only verify:

Ride 5001 + Captain ID + PIN 4821

Therefore, the same PIN can safely exist for multiple users because the ride context identifies the correct ride.

## Q9. PIN Storage Strategy

Compare these three designs:

Option A: PIN Stored on User
Users
-----

user_id
ride_pin

The same PIN may be reused across multiple rides.

Generate a temporary PIN when the captain approaches the pickup location.

Discuss the trade-offs between:

security
simplicity
database storage
user experience
PIN reuse
collision handling
Answer

I would prefer Option B: store the PIN on the Rides table and generate a new PIN for each ride.

For example:

Rides
-----

ride_id | user_id | captain_id | ride_pin | status
--------------------------------------------------

5001    | 101     | 201        | 4821     | WAITING
5002    | 102     | 202        | 7390     | WAITING

This makes the PIN specific to a particular ride.

Option A — PIN on User

Advantages:

Simple implementation
Easy for the user to remember
PIN can be reused

Disadvantages:

Same PIN is reused across rides
Lower security if the PIN is exposed
PIN is not specific to a particular ride
Option B — PIN on Ride

Advantages:

A new PIN can be generated for every ride
Better security
PIN is directly associated with the ride
Historical ride verification is easier

Disadvantages:

Requires storing the PIN for each ride
The user may need to handle a different PIN for every ride
Option C — Dynamic PIN

## Q10. What Indexes Would You Create?

Consider indexes such as:

```sql
Users(user_id)


Rides(ride_id)


Rides(user_id)


Rides(captain_id)


Rides(captain_id, status)


Payments(ride_id)

Which indexes would you create and why?

Would you index:

ride_pin
```

## Answer

I would create the following indexes:

```sql
Users(user_id)
Rides(ride_id)
Rides(user_id)
Rides(captain_id)
Rides(captain_id, status)
Payments(ride_id)
```

The primary keys:

Users(user_id)
Rides(ride_id)

are normally indexed automatically by the database.

Rides(user_id)

Used to quickly find all rides belonging to a particular user.

```sql
SELECT *
FROM rides
WHERE user_id = ?;
Rides(captain_id)
```

Used to find rides assigned to a particular captain.

Rides(captain_id, status)

This is particularly useful for finding a captain's active rides.
