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