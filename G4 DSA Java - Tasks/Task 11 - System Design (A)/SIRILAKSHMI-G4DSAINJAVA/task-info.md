# System Design Question: Ride Verification + Data Integrity

Design a ride-hailing system similar to Rapido.

Each rider has a **4-digit ride PIN** used to verify the ride when the captain picks them up.

A 4-digit PIN has only:

**10,000 possible values (`0000–9999`)**

However, the platform may have **millions of users**.

---

## Database Entities

Assume the system has the following tables:

### Users

```text
Users
-----
user_id       PRIMARY KEY
name
phone
ride_pin
```

### Captains

```text
Captains
--------
captain_id    PRIMARY KEY
name
vehicle_id
```

### Rides

```text
Rides
-----
ride_id       PRIMARY KEY
user_id       FOREIGN KEY → Users.user_id
captain_id    FOREIGN KEY → Captains.captain_id
status
created_at
```

### Payments

```text
Payments
--------
payment_id    PRIMARY KEY
ride_id       FOREIGN KEY → Rides.ride_id
amount
status
```

---

# Requirements

Design the system so that:

- Multiple users may have the **same 4-digit PIN**.
- A captain can only start the **correct active ride**.
- The captain must enter the rider's PIN before starting the ride.
- One user's PIN must not accidentally start another user's ride.
- The system should support **millions of users**.
- The system should support a high number of concurrent rides.
- PIN verification should be fast.
- Historical ride and payment information must remain consistent.

---

# Scenario: User Deletion

Suppose the database contains:

```text
User 101
   ↓
Ride 5001
   ↓
Payment 9001
```

The user requests that their account be deleted.

The application executes:

```sql
DELETE FROM users
WHERE user_id = 101;
```

Answer the following questions.

---

## Question 1: Foreign Key Behavior

`Rides.user_id` is a foreign key referencing:

```text
Users.user_id
```

What happens when we execute:

```sql
DELETE FROM users
WHERE user_id = 101;
```

while rides belonging to that user still exist?

Explain how the foreign key protects database integrity.

---

## Question 2: DELETE Strategy

Which strategy would you use between:

```text
Users → Rides
```

Choose between:

```sql
ON DELETE CASCADE
```

```sql
ON DELETE SET NULL
```

or:

```sql
ON DELETE RESTRICT
```

Explain your choice.

---

## Question 3: Historical Data

Should historical rides disappear when a user deletes their account?

For example:

```text
User 101
   ↓
Ride 5001
   ↓
Payment 9001
```

If User 101 deletes their account, should Ride 5001 and Payment 9001 also be deleted?

Why or why not?

---

## Question 4: Soft Delete vs Hard Delete

Would you physically delete the user:

```sql
DELETE FROM users
WHERE user_id = 101;
```

Or use a soft-delete strategy such as:

```text
is_deleted = true
```

Or anonymize the user's personal information?

For example:

```text
user_id = 101
name = NULL
phone = NULL
email = NULL
is_deleted = true
```

Discuss the advantages and disadvantages.

---

# Ride PIN Design

## Question 5: Only 10,000 PINs

A 4-digit PIN has:

```text
0000
0001
0002
...
9999
```

Therefore:

```text
10 × 10 × 10 × 10
= 10,000 possible PINs
```

But assume the system has:

```text
10,000,000 users
```

How would you assign 4-digit PINs to 10 million users?

Can multiple users share the same PIN?

How would the system distinguish them?

---

## Question 6: Should ride_pin Be UNIQUE?

Should this column have a unique constraint?

```sql
ride_pin VARCHAR(4) UNIQUE
```

Explain why this would or would not work for millions of users.

---

## Question 7: PIN Verification

Suppose a captain enters:

```text
4821
```

Should the system execute:

```sql
SELECT *
FROM users
WHERE ride_pin = '4821';
```

What problems could occur?

Instead, could the verification use the active ride context?

For example:

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

Explain why this approach is safer.

---

## Question 8: PIN Collision

Suppose:

```text
User A → PIN 4821
User B → PIN 4821
User C → PIN 7390
```

User A and User B both have active rides.

How does the system ensure that entering:

```text
4821
```

starts the correct ride?

What additional context should be checked?

Consider:

- ride_id
- captain_id
- user_id
- ride status
- PIN

---

# PIN Storage Strategy

## Question 9: Where Should the PIN Be Stored?

Compare these three designs.

### Option A: PIN Stored on User

```text
Users
-----
user_id
ride_pin
```

The same PIN may be reused across multiple rides.

Example:

```text
User A

Ride 1 → 4821
Ride 2 → 4821
Ride 3 → 4821
```

---

### Option B: PIN Stored on Ride

```text
Rides
-----
ride_id
user_id
captain_id
ride_pin
status
```

Example:

```text
Ride 1 → 4821
Ride 2 → 7390
Ride 3 → 1054
```

A new PIN is generated for every ride.

---

### Option C: Generate PIN Dynamically

Generate a temporary PIN when the captain approaches the pickup location.

Discuss the trade-offs between:

- security
- simplicity
- database storage
- user experience
- PIN reuse
- collision handling

---

# Indexing

## Question 10: What Indexes Would You Create?

Consider indexes such as:

```text
Users(user_id)

Rides(ride_id)

Rides(user_id)

Rides(captain_id)

Rides(captain_id, status)

Payments(ride_id)
```

Which indexes would you create and why?

Would you index:

```text
ride_pin
```

Why or why not?

---

# Primary Key Removal

Suppose someone accidentally executes:

```sql
ALTER TABLE users
DROP PRIMARY KEY;
```

Currently:

```text
Users.user_id
      ↑
      |
Rides.user_id
```

where:

```text
Rides.user_id
```

is a foreign key referencing:

```text
Users.user_id
```

Answer the following.

---

## Question 11

Can the primary key normally be removed while a foreign key depends on it?

What would most relational databases do?

---

## Question 12

Suppose you first remove the foreign key:

```sql
ALTER TABLE rides
DROP FOREIGN KEY fk_rides_user;
```

and then remove the primary key:

```sql
ALTER TABLE users
DROP PRIMARY KEY;
```

What data-integrity problems could occur?

For example, could the following become possible?

```text
Users

user_id | name
--------|------
101     | Ravi
101     | Amit
101     | John
```

What happens to this reference?

```text
Rides

ride_id | user_id
--------|--------
5001    | 101
```

Which user does `101` represent now?

---

# Advanced Questions

## Question 13: Concurrency

Two API requests arrive at almost exactly the same time:

```text
Captain Device 1 → Start Ride 5001 with PIN 4821
Captain Device 2 → Start Ride 5001 with PIN 4821
```

How would you ensure the ride is started only once?

Discuss:

- transactions
- row-level locking
- atomic updates
- optimistic locking

---

## Question 14: Atomic Ride Start

Would something like this help?

```sql
UPDATE rides
SET status = 'STARTED'
WHERE ride_id = ?
  AND captain_id = ?
  AND status = 'WAITING';
```

Then check:

```text
affected rows = 1
```

Why is this safer than:

```text
SELECT ride

then

UPDATE ride
```

as two separate unprotected operations?

---

## Question 15: PIN Guessing

A 4-digit PIN has only:

```text
10,000 possibilities
```

How would you prevent a captain or attacker from repeatedly trying:

```text
0000
0001
0002
0003
...
9999
```

Consider:

- rate limiting
- maximum attempts
- temporary lockout
- audit logs
- device identity
- captain identity

---

# Final Architecture Question

Design the complete flow:

```text
Rider books ride
        ↓
Ride record created
        ↓
Captain assigned
        ↓
Captain reaches pickup
        ↓
Rider provides 4-digit PIN
        ↓
Captain enters PIN
        ↓
Backend verifies:

ride_id
+
captain_id
+
user_id
+
ride status
+
PIN

        ↓
Valid?
   /        \
 Yes         No
  ↓           ↓
START       Reject
RIDE        request
```

Explain how your design handles:

- millions of users
- only 10,000 possible PIN values
- duplicate PINs
- foreign keys
- user deletion
- historical ride retention
- payment data
- indexes
- concurrency
- PIN brute-force attempts
- primary-key removal
- data integrity

---

# Interview Goal

A strong answer should connect:

**Database modeling + Primary Keys + Foreign Keys + OTP/PIN collisions + Indexing + Deletion policies + Transactions + Concurrency + Security + Ride-state validation**

Do not assume that a 4-digit PIN must be globally unique.
