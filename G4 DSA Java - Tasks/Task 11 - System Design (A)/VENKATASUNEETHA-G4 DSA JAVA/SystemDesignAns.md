# Answers

**Q1:** The DELETE fails with a foreign key constraint violation, since `Rides.user_id = 101` still references the user. The FK prevents orphaned/dangling rows in `Rides`.

**Q2:** `ON DELETE RESTRICT` (default `NO ACTION`). CASCADE would destroy ride/payment history; SET NULL would orphan financial records. RESTRICT forces the app to handle deletion explicitly (soft delete).

**Q3:** No. Ride 5001 and Payment 9001 must remain for financial/legal/audit reasons and for the captain's own records. Only the user's PII is removed, not the transaction.

**Q4:** Soft delete + anonymize (`is_deleted = true`, `name/phone/email = NULL`). Preserves referential integrity and audit trail, satisfies privacy laws without breaking FKs; hard delete would violate/cascade-break constraints and is irreversible.

**Q5:** PINs are not unique per user — millions of users share the same 10,000 values (~1,000 users/PIN). Assign randomly (per user or per ride). Disambiguation is done by ride context (`ride_id` + `captain_id` + `status`), not by the PIN itself.

**Q6:** No. `UNIQUE` on `ride_pin` would exhaust all 10,000 values almost immediately for millions of users. Uniqueness isn't needed since verification is scoped by ride context, not PIN alone.

**Q7:** No — `SELECT * FROM users WHERE ride_pin = ?` returns hundreds/thousands of ambiguous users. Use the scoped query:
```sql
SELECT r.* FROM rides r
JOIN users u ON r.user_id = u.user_id
WHERE r.ride_id = ? AND r.captain_id = ? AND r.status = 'WAITING' AND u.ride_pin = ?;
```
This is safer because it identifies the exact ride/captain first and uses the PIN only as a final match check, not a lookup key.

**Q8:** The system never searches by PIN. It uses the captain's already-assigned `ride_id`, checks `captain_id` matches, `status = 'WAITING'`, then verifies `ride_pin` on that one specific ride. User B's identical PIN on a different ride is never touched.

**Q9:**
- **Option A (PIN on User):** simplest, least storage, but PIN reused across rides → weaker security.
- **Option B (PIN on Ride):** fresh PIN per ride, better security, minor extra storage — **recommended default**.
- **Option C (dynamic generation near pickup):** strongest security (shortest exposure window), most implementation complexity — good as an enhancement on top of B.

**Q10:** Create indexes on `Users(user_id)` [PK], `Rides(ride_id)` [PK], `Rides(user_id)`, `Rides(captain_id)`, `Rides(captain_id, status)` [most valuable — supports "find captain's active ride"], `Payments(ride_id)`. Do **not** index `ride_pin` — low cardinality, never queried standalone, only checked as a single-row equality after the ride is already located.

**Q11:** No. Most RDBMS (MySQL, PostgreSQL, SQL Server, Oracle) reject dropping a primary key while a foreign key still references it, throwing a dependency error.

**Q12:** Once FK then PK are dropped, `user_id` uniqueness is no longer enforced, so duplicate `user_id = 101` rows (Ravi, Amit, John) become possible. `Rides.user_id = 101` becomes ambiguous — a join returns 3 matching rows instead of 1, corrupting ride history, payments, and PIN verification. This is a severe integrity failure.

**Q13:** Use an atomic conditional `UPDATE` (or `SELECT ... FOR UPDATE` inside a transaction) so only one of the two concurrent "start ride" requests succeeds; the other affects 0 rows and is treated as already-handled. Optimistic locking (version column) is an alternative.

**Q14:** Yes — the conditional `UPDATE ... WHERE status = 'WAITING'` with an `affected_rows == 1` check is atomic: the database locks/serializes the row so only one of two concurrent updates can match `WAITING`. A separate SELECT-then-UPDATE has a gap between read and write (TOCTOU race) where both requests can see `WAITING` and both proceed.

**Q15:** Rate limit PIN attempts per ride/captain, cap max attempts (e.g., 3–5) with temporary lockout after that, log every attempt (audit log), bind attempts to a registered captain device, and rely on `captain_id` already being part of the check so brute-force is scoped to one ride, not the whole platform. Short-lived per-ride PINs (Option B/C) further shrink the brute-force window.

## Final Architecture (one line each)

- **Millions of users / 10,000 PINs:** PIN is a scoped verification factor, not an identity lookup key.
- **Duplicate PINs:** resolved via `ride_id` + `captain_id` + `status`, not PIN uniqueness.
- **Foreign keys:** `RESTRICT` on Users→Rides and Rides→Payments to protect history.
- **User deletion:** soft delete + PII anonymization, never hard delete.
- **Historical retention:** Rides/Payments are immutable; only linked PII is scrubbed.
- **Indexes:** `Rides(captain_id, status)` is the key index; `ride_pin` is unindexed.
- **Concurrency:** atomic conditional `UPDATE` guarantees single-winner ride start.
- **Brute-force:** rate limiting + lockouts + device/captain binding + audit logs.
- **PK removal:** blocked by FK dependency unless explicitly dropped first — and doing so reintroduces ambiguous duplicate identities.
