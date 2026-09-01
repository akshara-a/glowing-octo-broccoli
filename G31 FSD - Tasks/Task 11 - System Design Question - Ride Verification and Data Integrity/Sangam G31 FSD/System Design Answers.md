# System Design: Ride Verification + Data Integrity

## Q1. Foreign Key Behavior

When I'm tried execute DELETE FROM users WHERE user_id = 101; and rides exist for that user, the database rejects the operation to protect integrity.
Only if i explicitly define a deletion rule (CASCADE, SET NULL, or RESTRICT) then it behave differently.

## Q2. DELETE Strategy

I prefer ON DELETE RESTRICT (or SET NULL if anonymization is required).

Why?

We must preserve historical rides and payments for compliance.

Cascading deletes would destroy critical records.

Restrict forces the application to handle user deletion carefully (e.g., soft delete + anonymization).

## Q3. Historical Data

No — historical rides and payments should not disappear when a user deletes their account.
They must remain for financial integrity, audits, and dispute resolution.
The correct approach is to retain rides/payments but anonymize or soft‑delete the user record.

## Q4. Soft Delete vs Hard Delete

Hard delete is too destructive.
Soft delete alone preserves history but may expose PII (name, phone, email).
Anonymization ensures privacy while keeping financial and operational records valid.
The strongest design is soft delete with anonymization.

## Q5. Only 10,000 PINs

Multiple users can share the same PIN.
The system distinguishes them by combining ride_id, captain_id, user_id, ride status, and PIN.
The PIN is only valid in the context of the active ride, not globally unique.
Best practice: store PINs on the Rides table, regenerate for each ride.

## Q6. Should `ride_pin` Be UNIQUE?

No — ride_pin should not have a unique constraint.
It would artificially limit the system to 10,000 users.
PINs are meant to be reused and validated in the ride context, not globally.
The correct design is to allow duplicates and enforce uniqueness only through ride_id + PIN combination.

## Q7. PIN Verification

We should not search the whole `Users` table using only the PIN because multiple users can have the same PIN. Instead, the backend should check the PIN together with `ride_id`, `captain_id`, and `status = 'WAITING'`. This makes sure the PIN is checked only for the correct active ride.

## Q8. PIN Collision

The system ensures correctness by validating ride_id + captain_id + user_id + ride status + PIN together.
This way, PIN collisions don’t matter — the ride can only be started if all conditions match the specific active ride assigned to that captain.

## Q9. PIN Storage Strategy

Option B: Store PIN on Ride
Balances security, simplicity, and auditability.
Each ride gets a fresh PIN, reducing collision risks.
Historical records remain consistent.
Option C is most secure but adds operational complexity; Option A is too weak for millions of users.

## Q10. What Indexes Would You Create?

Index all primary keys and foreign keys.
Add composite indexes for captain_id + status and ride_id + ride_pin + status.
Do not index ride_pin alone — it’s too small a space and causes collisions.
Always design indexes around query patterns (lookups by ride, captain, user, and payment).

## Q11. Primary Key Removal

No — you normally cannot remove a primary key while a foreign key depends on it.
Most relational databases will reject the operation to protect referential integrity.
You would first need to drop the foreign key constraints before removing the primary key, but doing so introduces serious risks 

## Q12. Removing the Foreign Key and Primary Key

If you drop the foreign key first and then remove the primary key, you open the door to duplicate user IDs and ambiguous references.
This breaks referential integrity: rides can no longer reliably point to a single user.
The system would be unable to guarantee which user a ride belongs to, leading to corrupted history and unreliable queries.

## Q13. Concurrency

Two requests may try to start the same ride at the same time. I would use a transaction with row-level locking or an atomic update. Only one request should be allowed to change the ride from `WAITING` to `STARTED`.

## Q14. Atomic Ride Start

An atomic UPDATE is safer because it eliminates the gap between SELECT and UPDATE where race conditions can occur.
With atomic logic, only one transaction can change the ride from WAITING to STARTED.
This guarantees that the ride is started exactly once, even under heavy concurrency.

## Q15. PIN Guessing

Design the Payments table with ride_id as a UNIQUE foreign key referencing Rides(ride_id).
This enforces one‑to‑one relationship: each ride has exactly one payment, and every payment belongs to a valid ride.

## Final Architecture

The complete flow would be:

## End‑to‑End Flow

1. **Rider books ride**  
   - Insert into `Rides` table with `ride_id`, `user_id`, status = `WAITING`.

2. **Ride record created**  
   - Foreign key: `Rides.user_id → Users.user_id`.  
   - Ensures only valid users can book rides.

3. **Captain assigned**  
   - Update `Rides.captain_id`.  
   - FK: `Rides.captain_id → Captains.captain_id`.

4. **Captain reaches pickup**  
   - System generates a **4‑digit PIN** (0000–9999).  
   - Stored in `Rides.ride_pin`.  
   - New PIN per ride → avoids long‑term collisions.

5. **Rider provides PIN**  
   - Rider sees PIN in app.  
   - Captain asks rider for PIN.

6. **Captain enters PIN**  
   - Backend verifies with atomic query:  
     ```sql
     UPDATE rides
     SET status = 'STARTED'
     WHERE ride_id = ?
       AND captain_id = ?
       AND user_id = ?
       AND status = 'WAITING'
       AND ride_pin = ?;
     ```
   - If affected_rows = 1 → ride starts.  
   - If 0 → reject request.

##  How the Design Handles Key Challenges

- **Millions of users**  
  - Primary keys (`user_id`, `ride_id`, `captain_id`) scale easily.  
  - Indexes ensure fast lookups.

- **Only 10,000 PINs**  
  - PINs reused across rides.  
  - Validated in ride context, not globally unique.

- **Duplicate PINs**  
  - Safe because verification checks `ride_id + captain_id + user_id + status + PIN`.

- **Foreign keys**  
  - Enforce integrity: rides must reference valid users/captains.  
  - Payments must reference valid rides.

- **User deletion**  
  - Use **soft delete + anonymization**.  
  - Preserve rides/payments, nullify PII.

- **Historical ride retention**  
  - Rides and payments never cascade delete.  
  - Ensures compliance and auditability.

- **Payment data**  
  - `Payments.ride_id UNIQUE FK → Rides.ride_id`.  
  - Guarantees one payment per ride.

- **Indexes**  
  - `Users(user_id)`  
  - `Rides(ride_id)`  
  - `Rides(user_id)`  
  - `Rides(captain_id, status)`  
  - `Payments(ride_id)`  
  - Composite `(ride_id, ride_pin, status)` for fast PIN verification.

- **Concurrency**  
  - Atomic UPDATE with status check.  
  - Row‑level locking ensures only one captain can start a ride.

- **PIN brute‑force attempts**  
  - Rate limiting per captain.  
  - Lockout after N failures.  
  - Audit logs for suspicious activity.

- **Primary‑key removal**  
  - Blocked if foreign keys exist.  
  - Prevents corruption.  
  - Dropping FK then PK → duplicates → broken integrity.

- **Data integrity**  
  - Preserved through PKs, FKs, soft deletes, and atomic transactions.  
  - Ensures reliable history and secure ride verification.



This architecture supports **millions of users**, handles **PIN collisions**, preserves **historical data**, enforces **foreign key integrity**, ensures **secure ride verification**, and prevents **race conditions**.  

It demonstrates mastery of:  
- **Database modeling** (PKs, FKs, constraints)  
- **PIN collision handling** (contextual validation, not global uniqueness)  
- **Indexing strategy** (composite indexes for query patterns)  
- **Deletion policies** (soft delete + anonymization)  
- **Transactions & concurrency** (atomic updates, row‑level locks)  
- **Security** (rate limiting, brute‑force prevention)  
- **Ride‑state validation** (status checks in queries)

