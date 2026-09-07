-- RIDE-HAILING SYSTEM DATABASE

-- SELECT DATA FROM EACH TABLES

SELECT * FROM users;
SELECT * FROM captains;
SELECT * FROM rides;
SELECT * FROM payments;

 
-- PIN VERIFICATION

SELECT r.ride_id, r.user_id, r.captain_id, r.status FROM rides r
WHERE r.ride_id = 5001
  AND r.captain_id = 201
  AND r.status = 'WAITING'
  AND r.ride_pin = 4078;


-- WRONG CAPTAIN TEST QUERY

SELECT rides.ride_id FROM rides
WHERE rides.ride_id  = 5001
  AND rides.captain_id =  202
  AND rides.status  = 'WAITING'
  AND rides.ride_pin =  4078;


-- WRONG PIN TEST QUERY

SELECT rides.ride_id FROM rides
WHERE rides.ride_id = 5001
  AND rides.captain_id = 201
  AND rides.status = 'WAITING'
  AND rides.ride_pin  = 4822;


-- RIDE START

UPDATE rides SET status =  'STARTED'
WHERE ride_id =  5001
  AND captain_id  = 201
  AND status  = 'WAITING'
  AND ride_pin  = 4078;

-- VERIFY RIDE STATUS

SELECT * FROM rides WHERE ride_id = 5001;


-- SECOND START ATTEMPT

UPDATE rides
SET status = 'STARTED'
WHERE ride_id = 5001
  AND captain_id = 201
  AND status = 'WAITING'
  AND ride_pin = 4821;


-- USER ANONYMIZATION


UPDATE users 
SET
    name =  NULL,
    phone =  NULL,
    email  = NULL,
    is_deleted  = TRUE
WHERE user_id = 1;

SELECT * FROM users WHERE user_id = 1;

-- Historical ride details preserved:
SELECT * FROM rides WHERE user_id = 1;

-- Historical payment details preserved:
SELECT rides.user_id, payments.*  FROM payments 
JOIN rides ON payments.ride_id = rides.ride_id
WHERE rides.user_id = 1;


-- HISTORICAL DATA CHECK


SELECT
    u.user_id,
    u.name,
    u.is_deleted,
    r.ride_id,
    r.status,
    p.payment_id,
    p.amount,
    p.status AS payment_status
FROM users u LEFT JOIN rides r
    ON r.user_id = u.user_id
LEFT JOIN payments p
    ON p.ride_id = r.ride_id
WHERE u.user_id = 1;


-- RIDES PER CAPTAIN

SELECT captain_id, COUNT(*) AS total_rides FROM rides GROUP BY captain_id;

-- SUCCESSFUL PAYMENTS

SELECT payment_id, ride_id, amount, status FROM payments WHERE status = 'SUCCESS';
