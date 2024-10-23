DELIMITER //
CREATE PROCEDURE UserLogin(
    IN p_username VARCHAR(50),
    IN p_password_hash VARCHAR(255)
)
BEGIN
    DECLARE v_user_id BIGINT;
    DECLARE v_stored_password_hash VARCHAR(255);
    DECLARE v_member_level INT;

    -- Check if the username exists
    SELECT id, password_hash, member_level INTO v_user_id, v_stored_password_hash, v_member_level
    FROM users
    WHERE username = p_username;

    -- Compare provided password hash with stored password hash
    IF v_stored_password_hash = p_password_hash THEN
              -- Successful login, return all details of the user
        SELECT * FROM users WHERE id = v_user_id;
    ELSE
        -- Incorrect password
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid username or password';
    END IF;
END //
DELIMITER ;
