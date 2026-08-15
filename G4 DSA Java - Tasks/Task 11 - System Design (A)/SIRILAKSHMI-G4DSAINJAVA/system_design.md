QUESTION 1: FOREIGN KEY BEHAVIOR

Rides.user_id is a foreign key referencing Users.user_id.

If we execute:

DELETE FROM users
WHERE user_id = 101;

while rides belonging to user 101 still exist, the database will normally reject the DELETE operation because existing records in the Rides table are referencing user 101.

The foreign key protects database integrity by ensuring that every user_id in the Rides table refers to a valid user in the Users table. This prevents orphan records, where a ride would refer to a user that no longer exists.


QUESTION 2: DELETE STRATEGY

For a ride-hailing system, I would prefer ON DELETE RESTRICT for the Users → Rides relationship.

ON DELETE RESTRICT prevents a user from being physically deleted while rides are still associated with that user. This is safer because ride information may be required for payment records, refunds, disputes, customer support, legal requirements, and historical records.

ON DELETE CASCADE is risky because deleting a user could automatically delete all their rides and related data.

ON DELETE SET NULL can be used only when user_id is allowed to be NULL and we intentionally want to keep the ride without its user reference.

Therefore, for important historical ride data, ON DELETE RESTRICT combined with soft deletion or anonymization is the safer approach.


QUESTION 3: HISTORICAL DATA

Historical rides and payments should normally NOT disappear when a user deletes their account.

For example:

User 101
   ↓
Ride 5001
   ↓
Payment 9001

If User 101 deletes their account, Ride 5001 and Payment 9001 should normally be retained because they may be required for transaction history, refunds, disputes, accounting, fraud investigation, customer support, and legal requirements.

Instead of deleting the complete history, the system can soft-delete or anonymize the user's personal information while keeping the necessary ride and payment records.

Therefore, user deletion should not automatically cascade into deletion of historical rides and payments.


QUESTION 4: SOFT DELETE VS HARD DELETE

I would prefer a soft-delete or anonymization strategy instead of physically deleting the user.

For example:

UPDATE users
SET is_deleted = true,
    name = NULL,
    phone = NULL,
    email = NULL
WHERE user_id = 101;

Advantages of soft delete:
1. Historical relationships remain valid.
2. Accidental deletion can be easier to recover from.
3. Ride and payment history can remain available.
4. Foreign key relationships are not broken.
5. It helps maintain audit and business records.

Disadvantages:
1. Deleted users still occupy database storage.
2. Queries must filter out deleted users when necessary.
3. Personal data must be handled carefully according to privacy requirements.

Hard deletion completely removes the user but can cause foreign key problems and loss of important historical information.

Therefore, soft delete or appropriate anonymization is generally better for a ride-hailing system.


QUESTION 5: ONLY 10,000 PINS

A 4-digit PIN has only 10,000 possible values:

0000 to 9999.

Since the system has 10 million users, it is impossible to assign a globally unique 4-digit PIN to every user.

Therefore, multiple users can share the same PIN.

For example:

User A → 4821
User B → 4821
User C → 7390

This is completely valid.

The system should NOT identify a ride only using the PIN. The PIN should be combined with additional information such as ride_id, captain_id, user_id, and ride status.

For example, when Captain A enters 4821, the backend checks the specific active ride assigned to that captain. Therefore, the PIN is only one verification factor and does not need to be globally unique.


QUESTION 6: SHOULD ride_pin BE UNIQUE?

No, ride_pin should normally NOT have a UNIQUE constraint if the PIN is a 4-digit value that can be reused.

For example:

User A → 4821
User B → 4821
User C → 4821

If we define:

ride_pin VARCHAR(4) UNIQUE

the database would allow only one record containing 4821. This would not work for millions of users or rides because there are only 10,000 possible PIN values.

Instead, ride_pin can have a normal index if searching by PIN is required, but uniqueness should come from the complete ride context rather than the PIN alone.

For example:

ride_id + captain_id + status + ride_pin

can be used during verification.


QUESTION 7: PIN VERIFICATION

The system should NOT execute:

SELECT *
FROM users
WHERE ride_pin = '4821';

This is unsafe because many users can have the same PIN. The query could return multiple users or identify the wrong user.

Instead, the backend should verify the PIN within the active ride context.

For example:

SELECT r.*
FROM rides r
JOIN users u
    ON r.user_id = u.user_id
WHERE r.ride_id = ?
  AND r.captain_id = ?
  AND r.status = 'WAITING'
  AND u.ride_pin = ?;

This is safer because the backend checks the specific ride, the assigned captain, the ride status, and the PIN together.

Therefore, even if thousands of users have the same PIN, the system can identify the correct ride using the ride context.


QUESTION 8: PIN COLLISION

Suppose:

User A → PIN 4821
User B → PIN 4821
User C → PIN 7390

User A and User B can both have active rides with the same PIN.

The system should never use the PIN alone to identify the ride.

When a captain enters 4821, the backend should verify:

1. ride_id
2. captain_id
3. user_id
4. ride status
5. PIN

For example:

WHERE ride_id = ?
AND captain_id = ?
AND status = 'WAITING'
AND user_id = ?
AND ride_pin = ?

The captain's assigned ride provides the necessary context. Therefore, duplicate PINs do not cause the wrong ride to start.

The important idea is that the PIN is not a unique identifier. The ride_id is the unique identifier, while the PIN is used as a verification factor.


QUESTION 9: WHERE SHOULD THE PIN BE STORED?

OPTION A: PIN STORED ON USER

Users
-----
user_id
ride_pin

In this design, the same PIN may be reused for multiple rides.

Advantages:
1. Simple database design.
2. Easy to store.
3. Less PIN generation.

Disadvantages:
1. The same PIN may be reused repeatedly.
2. If the PIN is compromised, it may be usable for future rides.
3. It is less secure because the PIN is associated with the user instead of a specific ride.

OPTION B: PIN STORED ON RIDE

Rides
-----
ride_id
user_id
captain_id
ride_pin
status

This is generally better for a ride-hailing system.

Each ride can receive a new PIN:

Ride 1 → 4821
Ride 2 → 7390
Ride 3 → 1054

Advantages:
1. Better security.
2. PIN is associated with a specific ride.
3. PIN can expire when the ride ends.
4. PIN reuse across rides is less of a concern.

OPTION C: DYNAMIC PIN

The system can generate a temporary PIN when the captain reaches the pickup location.

Advantages:
1. Better security.
2. PIN exists only for a short period.
3. Reduces the impact of a leaked PIN.

Disadvantages:
1. More implementation complexity.
2. Requires additional backend logic.
3. The user experience must handle PIN generation and expiration.

For a real-world system, storing a temporary PIN at the ride level is a strong and practical design.


QUESTION 10: WHAT INDEXES WOULD YOU CREATE?

Important indexes would include:

Users(user_id)
Rides(ride_id)
Rides(user_id)
Rides(captain_id)
Rides(captain_id, status)
Payments(ride_id)

Primary keys such as user_id and ride_id are normally indexed automatically by the database.

Rides(user_id) helps find all rides belonging to a particular user.

Rides(captain_id) helps find rides assigned to a captain.

Rides(captain_id, status) is useful for quickly finding the captain's active or waiting rides.

Payments(ride_id) helps quickly find payment information for a particular ride.

The ride_pin can also be indexed if the application frequently searches using it. However, it should NOT be made UNIQUE because duplicate PINs are allowed.

The exact indexes should be based on actual query patterns and database performance requirements.


QUESTION 11: CAN THE PRIMARY KEY BE REMOVED?

Normally, a primary key cannot simply be removed while a foreign key depends on it.

For example:

Users.user_id
     ↑
     |
Rides.user_id

Rides.user_id is a foreign key referencing Users.user_id.

The database normally prevents dropping the referenced primary key because doing so could break the foreign key relationship and violate referential integrity.

The exact error or behavior depends on the database system, but the database will require the dependent foreign key constraint to be removed or changed before removing the referenced key.

This protection prevents accidental destruction of important database relationships.


QUESTION 12: DATA INTEGRITY AFTER REMOVING THE FOREIGN KEY

Suppose we first remove the foreign key and then remove the primary key.

Without a primary key, duplicate user_id values could become possible:

Users

user_id | name
--------|------
101     | Ravi
101     | Amit
101     | John

Now consider:

Rides

ride_id | user_id
--------|--------
5001    | 101

The value 101 is ambiguous because it could refer to Ravi, Amit, or John.

The database no longer has a guaranteed unique identity for user 101.

This can cause serious problems such as incorrect joins, incorrect ride ownership, incorrect payments, duplicate users, and inconsistent data.

Therefore, primary keys and foreign keys are important for maintaining entity identity and referential integrity.


QUESTION 13: CONCURRENCY

Suppose two captain devices send requests at almost the same time:

Captain Device 1 → Start Ride 5001 with PIN 4821
Captain Device 2 → Start Ride 5001 with PIN 4821

Both requests must not be allowed to start the same ride twice.

The system can use transactions, row-level locking, atomic updates, or optimistic locking.

A transaction ensures that related database operations are treated as one consistent unit.

Row-level locking can prevent two transactions from modifying the same ride at the same time.

An atomic UPDATE can also solve this problem by changing the ride only if its current status is WAITING.

The database should be responsible for guaranteeing that only one request successfully changes the ride from WAITING to STARTED.


QUESTION 14: ATOMIC RIDE START

Yes, the following query is much safer:

UPDATE rides
SET status = 'STARTED'
WHERE ride_id = ?
  AND captain_id = ?
  AND status = 'WAITING';

After executing the query, we check the number of affected rows.

If:

affected rows = 1

the ride was successfully started.

If:

affected rows = 0

the ride was not started because the conditions were not satisfied, such as the ride already being STARTED or the captain being incorrect.

This is safer than:

SELECT ride

then

UPDATE ride

because the SELECT and UPDATE approach can create a race condition.

For example, two requests could both read WAITING before either request updates the ride.

An atomic UPDATE performs the condition check and state change together, allowing only one request to successfully change the ride.


QUESTION 15: PIN GUESSING

A 4-digit PIN has only 10,000 possibilities, so unlimited PIN attempts would be insecure.

The system should implement multiple security measures.

1. Rate limiting:
Limit the number of PIN attempts within a specific time period.

2. Maximum attempts:
For example, allow only a limited number of incorrect attempts.

3. Temporary lockout:
After too many failed attempts, temporarily block further attempts.

4. Audit logs:
Record failed and successful verification attempts for security monitoring.

5. Captain identity:
The verification should be associated with the authenticated captain account.

6. Ride identity:
The PIN should be checked only against the captain's assigned active ride.

7. Device identity:
Suspicious attempts from unknown or unusual devices can be monitored.

8. Ride expiration:
The PIN should become invalid after the ride starts, is cancelled, or expires.

Therefore, a PIN should never be treated as the only security mechanism. It should be combined with ride context, authentication, rate limiting, and ride-state validation.


FINAL ARCHITECTURE

The complete ride verification flow can be designed as:

Rider books ride
        ↓
Ride record is created
        ↓
A temporary 4-digit PIN is generated
        ↓
PIN is stored with the ride
        ↓
Captain is assigned
        ↓
Captain reaches pickup location
        ↓
Rider provides the PIN
        ↓
Captain enters the PIN
        ↓
Backend verifies:
ride_id
+
captain_id
+
ride status
+
PIN
        ↓
If all conditions are valid
        ↓
Ride status changes from WAITING to STARTED
        ↓
Ride begins

If the PIN is incorrect, the backend rejects the request and records the failed attempt.

The system does not require the 4-digit PIN to be globally unique. Since there are only 10,000 possible PINs, duplicate PINs are expected when the system has millions of users or rides.

The ride_id is the unique identifier, while the PIN is only used as a verification factor. The captain_id ensures that only the assigned captain can start the ride.

Foreign keys maintain relationships between Users, Rides, and Payments. Historical rides and payments should normally be retained even if a user deletes their account. Soft deletion or anonymization can be used instead of physically deleting the user.

Indexes should be created on frequently queried columns such as user_id, ride_id, captain_id, captain_id + status, and payment ride_id. A PIN may be indexed, but it should not be globally unique.

For concurrency, transactions, row-level locking, or atomic UPDATE statements should be used so that the same ride cannot be started twice.

Finally, PIN brute-force attacks should be prevented using rate limiting, maximum attempts, temporary lockouts, audit logs, captain authentication, and ride-state validation.

Overall, the design combines database modeling, primary keys, foreign keys, indexing, deletion policies, PIN collision handling, security, transactions, concurrency control, and ride-state validation to maintain data integrity and safely start the correct ride.
































""""

