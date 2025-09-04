
-- Creating customer_info table
CREATE TABLE IF NOT EXISTS customer_info (
    customer_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    dob DATE,
    email VARCHAR(100),
    phone_number VARCHAR(20),
    address VARCHAR(200),
    state VARCHAR(50),
    account_status VARCHAR(20),
    account_type VARCHAR(20),
    date_created TIMESTAMP
);

-- Creating merchant_info table
CREATE TABLE IF NOT EXISTS merchant_info (
    merchant_id SERIAL PRIMARY KEY,
    merchant_name VARCHAR(100),
    merchant_type VARCHAR(50),
    merchant_address VARCHAR(200),
    merchant_state VARCHAR(50),
    merchant_category VARCHAR(50)
);


-- Creating transactions table
CREATE TABLE IF NOT EXISTS transactions (
    transaction_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customer_info(customer_id),
    merchant_id INT REFERENCES merchant_info(merchant_id),
    transaction_date TIMESTAMP,
    transaction_type VARCHAR(50),
    amount NUMERIC(15,2),
    transaction_status VARCHAR(50),
    transaction_address VARCHAR(200),
    transaction_state VARCHAR(50),
    channel VARCHAR(50),
    transaction_device VARCHAR(50),
    fraud_flag BOOLEAN
);


-- Creating fraud_detection_logs table
CREATE TABLE IF NOT EXISTS fraud_detection_logs (
    log_id SERIAL PRIMARY KEY,
    transaction_id INT REFERENCES transactions(transaction_id),
    detection_date TIMESTAMP,
    fraud_type VARCHAR(50),
    detector_system VARCHAR(50),
    fraud_status VARCHAR(20),
    comments TEXT
);

-- Creating fraudulent_patterns table
CREATE TABLE IF NOT EXISTS fraudulent_patterns (
    pattern_id SERIAL PRIMARY KEY,
    pattern_name VARCHAR(100),
    pattern_details TEXT,
    severity_level VARCHAR(20),
    is_active BOOLEAN
);

-- Transaction Patterns (Bridge Table)
CREATE TABLE IF NOT EXISTS transaction_patterns (
    transaction_id INT REFERENCES transactions(transaction_id),
    pattern_id INT REFERENCES fraudulent_patterns(pattern_id),
    PRIMARY KEY(transaction_id, pattern_id)
);


-- Creating transaction_flags table
CREATE TABLE IF NOT EXISTS transaction_flags (
    flag_id SERIAL PRIMARY KEY,
    transaction_id INT REFERENCES transactions(transaction_id),
    flag_type VARCHAR(50),
    flag_reason TEXT,
    flag_date TIMESTAMP,
    resolved BOOLEAN
);

ALTER TABLE customer_info REPLICA IDENTITY FULL;
ALTER TABLE merchant_info REPLICA IDENTITY FULL;
ALTER TABLE transactions REPLICA IDENTITY FULL;
ALTER TABLE fraud_detection_logs REPLICA IDENTITY FULL;
ALTER TABLE fraudulent_patterns REPLICA IDENTITY FULL;
ALTER TABLE transaction_patterns REPLICA IDENTITY FULL;
ALTER TABLE transaction_flags REPLICA IDENTITY FULL;
