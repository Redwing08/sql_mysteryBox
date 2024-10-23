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






