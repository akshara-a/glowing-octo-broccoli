-- RIDE-HAILING SYSTEM DATABASE

-- USERS TABLE

CREATE TABLE users (
    user_id INTEGER PRIMARY KEY,
    name VARCHAR(40),
    phone VARCHAR(10),
    email VARCHAR(60),
    is_deleted BOOLEAN NOT NULL DEFAULT FALSE
);

-- CAPTAINS TABLE 

CREATE TABLE captains (
    captain_id INTEGER PRIMARY KEY,
    name VARCHAR(40) NOT NULL,
    vehicle_id VARCHAR(10) NOT NULL UNIQUE
);


-- RIDES TABLE 

CREATE TABLE rides (
    ride_id INTEGER PRIMARY KEY,
    user_id INTEGER,
    captain_id INTEGER NOT NULL,
    ride_pin INTEGER NOT NULL,
    status VARCHAR(20) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_rides_user
        FOREIGN KEY (user_id)
        REFERENCES users(user_id)
        ON DELETE RESTRICT,

    CONSTRAINT fk_rides_captain
        FOREIGN KEY (captain_id)
        REFERENCES captains(captain_id)
);

 
-- PAYMENTS TABLE

CREATE TABLE payments (
    payment_id INTEGER PRIMARY KEY,
    ride_id INTEGER NOT NULL,
    amount NUMERIC(10,2) NOT NULL,
    status VARCHAR(20) NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT fk_payments_ride
        FOREIGN KEY (ride_id)
        REFERENCES rides(ride_id)
);

-- INSERT USERS

INSERT INTO users (user_id, name, phone, email)
VALUES
    (1, 'Ragavi', '9876543210', 'ragavi@gmail.com'),
    (2, 'Priya', '9876543211', 'priya@gmail.com'),
    (3, 'Cathreena', '9876543213', 'cathreena@gmail.com'),
    (4, 'Aambal', '9347485950', 'aambal@gmail.com'),
    (5, 'Chezhian', '9876543214', 'chezhian@gmail.com');

-- INSERT CAPTAINS

INSERT INTO captains (captain_id, name, vehicle_id)
VALUES
    (201, 'Amudhan', 'TN31CD4588'),
    (202, 'Thamizh', 'TN45AQ8324'),
    (203, 'Sham', 'TN40CD9457');

 
-- INSERT RIDES

INSERT INTO rides(ride_id, user_id, captain_id, ride_pin, status)
VALUES
    (5001, 1, 201, 4078, 'WAITING'),
    (5002, 2, 202, 4078, 'WAITING'),
    (5003, 3, 203, 7390, 'WAITING'),
    (5004, 4, 201, 1054, 'COMPLETED'),
    (5005, 5, 201, 1054, 'COMPLETED');

-- INSERT PAYMENTS

INSERT INTO payments(payment_id, ride_id, amount, status)
VALUES
    (9001, 5001, 250.00, 'SUCCESS'),
    (9002, 5002, 180.00, 'SUCCESS'),
    (9003, 5003, 320.00, 'SUCCESS'),
    (9004, 5004, 150.00, 'SUCCESS'),
    (9005, 5005, 130.00, 'PROCESSING');

 
-- INSERT INDEXES
 
CREATE INDEX idx_rides_user_id ON rides(user_id);

CREATE INDEX idx_rides_captain_id ON rides(captain_id);