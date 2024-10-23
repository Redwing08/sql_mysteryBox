--users table here 

CREATE TABLE users (     
id BIGINT PRIMARY KEY AUTO_INCREMENT,     
username VARCHAR(50) UNIQUE NOT NULL,    
 email VARCHAR(100) UNIQUE NOT NULL,    
 password_hash VARCHAR(255) NOT NULL,  
 referral_code VARCHAR(10) UNIQUE NOT NULL,     
referrer_id BIGINT,     
credits DECIMAL(10,2) DEFAULT 1000.00,    
 member_level INT DEFAULT 0,      
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,     FOREIGN KEY (referrer_id) REFERENCES users(id) );


--Treasure_Types
CREATE TABLE treasure_types (
id BIGINT PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(100) NOT NULL,
description TEXT,
initial_quantity INT DEFAULT 100,
remaining_quantity INT DEFAULT 100,
image_url VARCHAR(255),
amount DECIMAL(10,2) NOT NULL,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

--Mystery_Purchases
CREATE TABLE  mystery_purchases (
id BIGINT PRIMARY KEY AUTO_INCREMENT,
user_id BIGINT NOT NULL,
treasure_type_id BIGINT NOT NULL,
price DECIMAL(10,2) NOT NULL,
purchased_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (user_id) REFERENCES users(id),
FOREIGN KEY (treasure_type_id) REFERENCES treasure_types(id)
);

--Credit_Transactions
CREATE TABLE credit_transactions (
id BIGINT PRIMARY KEY AUTO_INCREMENT,
user_id BIGINT NOT NULL,
amount DECIMAL(10,2) NOT NULL,
transaction_type ENUM('PURCHASE', 'INITIAL') NOT NULL,
reference_id BIGINT,
created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY (user_id) REFERENCES users(id)
);