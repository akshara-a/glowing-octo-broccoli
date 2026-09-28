Q1. Foreign Key Behavior

Rides.user_id is a foreign key referring to Users.user_id.

If we try to delete a user who still has rides, the database will normally reject the deletion.

DELETE FROM users WHERE user_id = 101;

This protects the database from having rides that refer to a user who no longer exists.

Q2. DELETE Strategy

I would use:

ON DELETE RESTRICT

because deleting a user should not automatically delete their rides.

CASCADE → deletes rides ❌
SET NULL → removes the user relationship
RESTRICT → prevents accidental deletion ✅
Q3. Historical Data

Historical rides and payments should not be deleted when a user deletes their account.

For example:

User 101
   ↓
Ride 5001
   ↓
Payment 9001

The ride and payment may be needed for refunds, disputes, accounting, and auditing.

Q4. Soft Delete vs Hard Delete

I would prefer soft delete.

Instead of physically deleting the user:

DELETE FROM users WHERE user_id = 101;

we can use:

is_deleted = true

Personal information such as name, phone, and email can also be anonymized if required.

This keeps historical relationships while removing the user's active account.

Q5. Only 10,000 PINs

A 4-digit PIN has only 10,000 possible values.

Therefore, millions of users cannot have unique PINs.

Multiple users can have the same PIN:

User A → 4821
User B → 4821
User C → 7390

The system identifies the correct user through the ride and captain information, not the PIN alone.

Q6. Should ride_pin Be UNIQUE?

No.

We should not use:

ride_pin VARCHAR(4) UNIQUE

because multiple users may have the same PIN.

The PIN can repeat, while user_id and ride_id remain unique.

Q7. PIN Verification

We should not run:

SELECT * FROM users
WHERE ride_pin = '4821';

because many users may have 4821.

Instead, verify the PIN using the active ride:

ride_id
+
captain_id
+
PIN
+
status

This ensures that the PIN belongs to the correct rider and active ride.

Q8. PIN Collision

Suppose:

User A → 4821
User B → 4821

This is allowed.

If User A's ride is:

Ride 5001
Captain 300
PIN 4821

the backend checks all these values.

Therefore, Captain 300 entering 4821 can only start the correct assigned ride.

Q9. Where Should the PIN Be Stored?

There are three choices.

User table: Simple, but the same PIN is reused for every ride.

Ride table: A new PIN can be generated for every ride. This is more secure and easier to verify.

Dynamic PIN: Generate a temporary PIN when the captain reaches the rider. This is more secure but more complex.

Recommended: Store a temporary, ride-specific PIN.

Q10. Indexes

Useful indexes include:

Users(user_id)
Rides(ride_id)
Rides(user_id)
Rides(captain_id)
Rides(captain_id, status)
Payments(ride_id)

These indexes make common searches faster.

For example, Rides(captain_id, status) helps find a captain's active rides quickly.

Q11. Primary Key Removal

Normally, we cannot simply remove Users.user_id primary key while Rides.user_id depends on it through a foreign key.

The database will usually reject the operation because the foreign key depends on the referenced key.

Q12. Removing Foreign Key and Primary Key

If we remove the foreign key and primary key, duplicate user IDs could be created:

101 → Ravi
101 → Amit
101 → John

Now a ride containing:

user_id = 101

cannot reliably identify which user it belongs to.

This causes serious data-integrity problems.

Q13. Concurrency

Two requests could try to start the same ride at the same time.

To prevent this, use:

Database transactions
Row-level locking
Atomic updates
Optimistic locking

The goal is to allow the ride to change from WAITING to STARTED only once.

Q14. Atomic Ride Start

This is safer:

UPDATE rides
SET status = 'STARTED'
WHERE ride_id = ?
AND captain_id = ?
AND status = 'WAITING';

Then check the affected rows.

1 row → Ride started
0 rows → Ride was already started or request is invalid

This is safer than doing SELECT and UPDATE separately because it prevents race conditions.

Q15. PIN Guessing

Because there are only 10,000 PINs, brute-force attacks are possible.

Use:

Rate limiting
Maximum attempts
Temporary lockout
Audit logs
Captain/device verification

For example, after several wrong attempts, temporarily block further PIN attempts.

Final Architecture
Rider books ride
       ↓
Ride created
       ↓
Captain assigned
       ↓
Temporary PIN generated
       ↓
Captain reaches rider
       ↓
Captain enters PIN
       ↓
Backend checks:
Ride ID
Captain ID
PIN
Ride Status
       ↓
   Correct?
    /    \
  Yes     No
   ↓       ↓
 START    Reject
 RIDE     request