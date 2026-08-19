# Ride Hailing System

## Q1. Foreign Key Behavior

The rides table refers to the user_id in the user_table.
Since the rides table has the reference of users id, the users in the users table cannot be deleted due to referential integrity. 

## Q2. DELETE Strategy

I have used ON DELETE RESTRICT and soft delete the user.
Because deleting a user could delete their historical rides and payments which are needed for transaction record maintainance.

## Q3. Historical Data

Historical rides and payments should remain after user deletion because they may be needed for auditing and transaction history maintanance.so only the user's personal information should be removed.

## Q4. Soft Delete vs Hard Delete

I have used soft delete with anonymization so that user_id remains in users table but their personal data is deleted and hence the problem of missing historical data and privacy issue is solved.

## Q5. 4-Digit PIN

There are only 10,000 possible PINs and multiple users can have the same PIN.

User A has the ride pin as 4821
User B has the ride pin as 4821

In this system, the PIN does not identify the user and the ride_id and captain_id are used to identify the respective rides of the user.


## Q6. UNIQUE Constraint

Since only numeric 4-digit numbers are used as pin, there would be repetitions and therfore the pin is not made unique.

## Q7. PIN Verification

The ride pin is verified using the ride_id, captain_id, status and the ride pin.

```sql
SELECT ride_id
FROM rides
WHERE ride_id = 5001
  AND captain_id = 201
  AND status = 'WAITING'
  AND ride_pin = 4821;
```

## Q8. PIN Collision

Even if two users are having the same ride pin of 4821, the system can function properly.  

ride_id  | user_id | captain_id | ride_pin |  status   |         created_at         
---------+---------+------------+----------+-----------+----------------------------
    5001 |     101 |        215 |     4002 | WAITING   | 2026-08-18 00:16:26.564515
    5002 |     103 |        216 |     4002 | WAITING   | 2026-08-18 00:16:26.564515

Because the combination of ride_id, captain_id, ride_pin and status will always be unique.

## Q9. PIN Storage

I have stored the ride_pin in the rides table so that every new ride for a user would have new ride pin.


```text
Rides
----------------
ride_id
user_id
captain_id
ride_pin
status
created_at
```


## Q10. Indexing

I would create index for the below column: 


Rides(user_id)                : It helps to find the users quickly from the rides table.

Rides(captain_id, status)     : It helps to find the captains whose status is either started or completed.



## Q11. Primary Key Removal

```text
ALTER TABLE users
DROP PRIMARY KEY;
```

Removing Primary Key from a table leads to insertion of duplicate records with same user_id that leads to ambiguity.


## Q12. Removing the Foreign Key First

```text
ALTER TABLE rides
DROP FOREIGN KEY fk_rides_user;
```

If the foreign key is removed, then user IDs that are not present in users table can also be inserted which results in inconsistency and affects the tables relations.


Users Table 

user_id |  name   |   phone      | email                | is_deleted 
--------|---------|--------------|----------------------|------------
101     | 'Priya' | '8940021232' | 'priya@gmail.com'    |  false
102     | 'Hema'  | '9834662737' | 'hema@gmail.com'     |  false
103     | 'Sara'  | '9744672289' | 'sara@gmail.com'     |  false


Rides Table 

ride_id | user_id
--------|--------
5001    | 101
5002    | 300 



## Q13. Concurrency

When two captains send a request at the same time, only one request can change the status of ride from WAITING to STARTED and this mechanism is achieve through atomic update. 


## Q14. Atomic Ride Start

```sql
UPDATE rides
SET status = 'STARTED'
WHERE ride_id = 5001
  AND captain_id = 201
  AND status = 'WAITING'
  AND ride_pin = 4821;
```

This query helps to protect the atomic behaviour and prevents inconsistency.

## Q15. PIN Guessing

To prevent the pin being guessed, attempts can be limited if the limit reaches 3 and resume the pin verification after five minutes.


# Final Architecture

```text
1. Book a ride

2. (a)Add user entry in users table 
   (b) Add ride entry in ride table with the ride pin
   (c) Assign a captain to the ride table

3. Captain verifies the ride pin with the user

4. Check the ride_id + captain_id + status + PIN

5. If the combination gives valid result then start ride else reject

6. After ride, proceed with the payments process
```
