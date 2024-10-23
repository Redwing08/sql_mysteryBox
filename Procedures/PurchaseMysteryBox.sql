DELIMITER //
CREATE PROCEDURE PurchaseMysteryBox(IN p_user_id BIGINT)
BEGIN
    DECLARE v_remaining_quantity INT;
    DECLARE v_credits DECIMAL(10,2);
    DECLARE v_treasure_type_id BIGINT;
    DECLARE v_amount DECIMAL(10,2);
    -- Start transaction
    START TRANSACTION;
    -- Check if the user has enough credits
    SELECT credits INTO v_credits FROM users WHERE id = p_user_id FOR UPDATE;
    IF v_credits < 100 THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Not enough credits';
    END IF;
    -- Select a random treasure type that still has remaining inventoryc
    SELECT id, amount, remaining_quantity INTO v_treasure_type_id, v_amount, v_remaining_quantity
    FROM treasure_types
    WHERE remaining_quantity > 0
    ORDER BY RAND() --this rand function will be responsible po for random orders
    LIMIT 1
    FOR UPDATE;  -- Locking the selected treasure type
    -- Check if a treasure is available
    IF v_treasure_type_id IS NULL THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No available treasure';
    END IF;
    -- Check if the selected treasure has remaining quantity
    IF v_remaining_quantity <= 0 THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'No available treasure';
    END IF;
    -- Deduct the treasure price from user's credits
    UPDATE users
    SET credits = credits - v_amount
    WHERE id = p_user_id;
    -- Insert the purchase into the mystery_purchases table
    INSERT INTO mystery_purchases (user_id, treasure_type_id, price)
    VALUES (p_user_id, v_treasure_type_id, v_amount);
    -- Update the remaining quantity of the purchased treasure
    UPDATE treasure_types
    SET remaining_quantity = remaining_quantity - 1
    WHERE id = v_treasure_type_id;
    -- Add the purchase transaction to the credit_transactions table
    INSERT INTO credit_transactions (user_id, amount, transaction_type)
    VALUES (p_user_id, v_amount, 'PURCHASE');
    -- Commit the transaction
    COMMIT;
END //
DELIMITER ;