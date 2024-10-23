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