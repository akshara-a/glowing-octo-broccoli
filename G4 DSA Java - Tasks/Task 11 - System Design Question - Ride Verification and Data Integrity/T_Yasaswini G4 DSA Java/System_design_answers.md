# Q1. Foreign Key Behavior

**Answer:**  
If `Rides.user_id` references `Users.user_id`, deleting a user who still has rides will normally fail with a foreign key constraint error.

The foreign key protects data by preventing rides from pointing to a user that does not exist.

---

# Q2. DELETE Strategy

**Answer:**  
I would choose:

```sql
ON DELETE RESTRICT
```

because rides are historical records and should not be automatically deleted when a user is deleted.

`CASCADE` can delete important ride and payment history. `SET NULL` can be used when we intentionally want to remove the user relationship.

---

# Q3. Historical Data

**Answer:**  
No. Historical rides and payments should normally remain.

For example:

```text
User 101 → Ride 5001 → Payment 9001
```

After deleting the user's personal information, `Ride 5001` and `Payment 9001` should remain for:

- Payment records
- Refunds
- Disputes
- Auditing
- Business history

---

# Q4. Soft Delete vs Hard Delete

**Answer:**  
I would prefer **soft delete with anonymization**.

Example:

```text
user_id = 101
name = NULL
phone = NULL
email = NULL
is_deleted = true
```

This keeps historical relationships while removing personal information.

**Advantages:**
- Historical rides remain.
- Payments remain.
- Easier auditing.
- Prevents accidental data loss.

**Disadvantages:**
- More storage is required.
- Queries must check `is_deleted`.
- Personal data must be properly anonymized.

---

# Q5. Only 10,000 PINs

**Answer:**  
Multiple users can have the same PIN.

Example:

```text
User A → 4821
User B → 4821
User C → 7390
```

This is valid because the PIN is not the user's identity.

The system identifies users using:

```text
user_id
```

and identifies rides using:

```text
ride_id
```

---

# Q6. Should `ride_pin` Be UNIQUE?

**Answer:**  
No.

This should **not** be used:

```sql
ride_pin VARCHAR(4) UNIQUE
```

because there are only 10,000 possible PINs but millions of users.

Multiple users must be allowed to have the same PIN.

---

# Q7. PIN Verification

**Answer:**  
No. We should not search only by PIN:

```sql
SELECT *
FROM users
WHERE ride_pin = '4821';
```

This could return many users.

Instead, use the specific ride:

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

This is safer because it checks:

```text
Correct ride
+ Correct captain
+ Active ride
+ Correct PIN
```

---

# Q8. PIN Collision

**Answer:**  
If two users have:

```text
User A → 4821
User B → 4821
```

the PIN alone cannot identify them.

The backend also checks:

```text
ride_id
captain_id
user_id
ride status
PIN
```

For example:

```text
Ride 5001 → User A → Captain X → 4821
Ride 8001 → User B → Captain Y → 4821
```

Captain X can only start Ride 5001.

---

# Q9. Where Should the PIN Be Stored?

**Answer:**  

### Option A — User PIN

```text
Users → ride_pin
```

Simple, but the same PIN is reused for many rides.

### Option B — Ride PIN

```text
Rides → ride_pin
```

A new PIN is generated for every ride.

This provides better security because an old PIN becomes useless.

### Option C — Dynamic PIN

Generate a temporary PIN shortly before pickup.

This provides better security but requires more logic for expiration and synchronization.

**My choice:**  
Use a **random PIN for each ride** and store it with the ride or a secure verification record.

---

# Q10. Indexes

**Answer:**  

Primary keys already have indexes:

```text
Users(user_id)
Rides(ride_id)
```

I would also create:

```text
Rides(user_id)
Rides(captain_id, status)
Payments(ride_id)
```

These help with common queries such as:

```text
Find user's rides
Find captain's active ride
Find payment for a ride
```

I would not depend on `ride_pin` for searching because duplicate PINs are allowed.

---

# Q11. Can the Primary Key Be Removed?

**Answer:**  
Normally, no.

If:

```text
Rides.user_id
```

has a foreign key referencing:

```text
Users.user_id
```

the database normally prevents removing the referenced primary key.

This protects referential integrity.

---

# Q12. Removing the Foreign Key First

**Answer:**  
If we remove the foreign key and primary key, duplicate user IDs could become possible:

```text
101 → Ravi
101 → Amit
101 → John
```

Now:

```text
Ride 5001 → user_id 101
```

is ambiguous.

The database cannot know whether `101` means Ravi, Amit, or John.

This can cause incorrect data and broken relationships.

---

# Q13. Concurrency

**Answer:**  
Two requests may try to start the same ride at the same time.

We must make the operation atomic.

Use:

```sql
UPDATE rides
SET status = 'STARTED'
WHERE ride_id = ?
  AND captain_id = ?
  AND status = 'WAITING';
```

Then check:

```text
affected_rows = 1
```

Only one request should successfully change the ride from `WAITING` to `STARTED`.

We can also use transactions and row-level locking.

---

# Q14. Atomic Ride Start

**Answer:**  
Yes, this is safer:

```sql
UPDATE rides
SET status = 'STARTED'
WHERE ride_id = ?
  AND captain_id = ?
  AND status = 'WAITING';
```

Because checking and updating happen together.

If two requests arrive:

```text
Request 1 → affected rows = 1
Request 2 → affected rows = 0
```

The second request cannot start the ride again.

This is safer than:

```text
SELECT ride
      ↓
Check status
      ↓
UPDATE ride
```

because the two-step approach can have a race condition.

---

# Q15. PIN Guessing

**Answer:**  
Because there are only 10,000 PINs, brute-force protection is required.

Use:

- Rate limiting
- Maximum failed attempts
- Temporary lockout
- Captain identity checking
- Device checking
- Audit logs

Example:

```text
5 wrong attempts
       ↓
Temporary lock
```

Also use a short-lived, per-ride PIN.

Never store PINs in application logs.

---

# Final Architecture

**Answer:**

```text
Rider books ride
       ↓
Create ride
       ↓
Assign captain
       ↓
Ride status = WAITING
       ↓
Generate 4-digit PIN
       ↓
Captain reaches pickup
       ↓
Rider gives PIN
       ↓
Captain sends ride_id + PIN
       ↓
Backend verifies:
    ride_id
    captain_id
    user_id
    status
    PIN
       ↓
Valid?
  /       \
Yes       No
 ↓         ↓
START     Reject
RIDE      request
```

The important points are:

- PIN does not need to be unique.
- Multiple users can have the same PIN.
- `ride_id` identifies the exact ride.
- `captain_id` identifies the authorized captain.
- `user_id` identifies the rider.
- `status` ensures the ride is active.
- Foreign keys protect relationships.
- Historical rides and payments are retained.
- Soft delete/anonymization protects user history.
- Indexes make queries fast.
- Atomic updates prevent double ride starts.
- Rate limiting prevents PIN brute-force attacks.
- Primary keys and foreign keys protect data integrity.

### Simple Interview Summary

> **A 4-digit PIN is not a unique identity. Multiple users can have the same PIN. The backend uses the PIN together with `ride_id`, `captain_id`, `user_id`, and ride status to verify the correct ride. Foreign keys protect data integrity, historical rides and payments are retained, and an atomic database update ensures that a ride can be started only once.**