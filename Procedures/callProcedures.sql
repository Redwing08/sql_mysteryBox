-- REGISTER USERS FUNCTIONS
CALL RegisterUser(
    'fdfdf',          -- Username
    'fdfdf@email.com', -- Email
    'password123',-- Password Hash
    NULL   -- No referral code (NULL)
);

--PURCHASE MYSTERY BOX FUNCTIONS 

CALL PurchaseMysteryBox(1); -- Assuming user_id 1 purchase a mystery box



--UPDATE USER MEMBERSHIP LEVELS
CALL UpdateUserLevels();



--CHECK THE REMAINING TREASURES LEFT
CALL GetRemainingTreasureQuantities();


--LOGIN 
CALL UserLogin('example', 'Password123');

