DELIMITER // --I used looping for the propagation of MEMBER LEVELS PO
CREATE PROCEDURE UpdateUserLevels()
BEGIN
    DECLARE v_user_id BIGINT;
    DECLARE v_referral_count INT;
    DECLARE v_level_1_count INT;
    DECLARE done INT DEFAULT FALSE;

    -- Declare a cursor to loop through all users
    DECLARE user_cursor CURSOR FOR 
    SELECT id FROM users;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    -- Open the cursor
    OPEN user_cursor;
    -- Loop through each user
    read_loop: LOOP
        FETCH user_cursor INTO v_user_id;
        IF done THEN
            LEAVE read_loop;
        END IF;
        -- Count how many referrals made purchases
        SELECT COUNT(DISTINCT u.id) INTO v_referral_count
        FROM users u
        JOIN mystery_purchases mp ON u.id = mp.user_id
        WHERE u.referrer_id = v_user_id;
        -- Count how many referrals are Level 1
        SELECT COUNT(DISTINCT u.id) INTO v_level_1_count
        FROM users u
        WHERE u.referrer_id = v_user_id AND u.member_level = 1;
        -- Update user to level 1 if they referred at least 2 users who made purchases
        IF v_referral_count >= 2 THEN
            UPDATE users SET member_level = 1 WHERE id = v_user_id;
        END IF;
        -- Update user to level 2 if they referred at least 2 Level 1 users
        IF v_level_1_count >= 2 THEN
            UPDATE users SET member_level = 2 WHERE id = v_user_id;
        END IF;
    END LOOP;
    -- Close the cursor
    CLOSE user_cursor;
END //
DELIMITER ;