DELIMITER //
CREATE PROCEDURE GetRemainingTreasureQuantities()
BEGIN
    SELECT name, remaining_quantity
    FROM treasure_types;
END //
DELIMITER ;