DELIMITER //
CREATE PROCEDURE RegisterUser(
    IN p_username VARCHAR(50),
    IN p_email VARCHAR(100),
    IN p_password_hash VARCHAR(255),
    IN p_referral_code VARCHAR(10)
)
BEGIN
    DECLARE referrer_user_id BIGINT;
    
    -- Check if referral code is provided and exists
    IF p_referral_code IS NOT NULL THEN
        SELECT id INTO referrer_user_id
        FROM users
        WHERE p_referral_code = p_referral_code;
        
        -- If referral code exists, insert new user with the referrer_id
        IF referrer_user_id IS NOT NULL THEN
            INSERT INTO users (username, email, password_hash, referral_code, referrer_id, credits)
            VALUES (p_username, p_email, p_password_hash, LEFT(UUID(), 10), referrer_user_id, 1000);
        ELSE
            -- Referral code does not exist, insert without referrer_id
            INSERT INTO users (username, email, password_hash, referral_code, credits)
            VALUES (p_username, p_email, p_password_hash, LEFT(UUID(), 10), 1000);
        END IF;
    ELSE
        -- No referral code provided, insert user without referrer_id
        INSERT INTO users (username, email, password_hash, referral_code, credits)
        VALUES (p_username, p_email, p_password_hash, LEFT(UUID(), 10), 1000);
    END IF;
    -- Add initial credit transaction
    INSERT INTO credit_transactions (user_id, amount, transaction_type)
    VALUES (LAST_INSERT_ID(), 1000, 'INITIAL');
    
END //
DELIMITER ;