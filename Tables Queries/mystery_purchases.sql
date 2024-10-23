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