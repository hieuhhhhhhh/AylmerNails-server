DROP PROCEDURE IF EXISTS sp_remove_group;

CREATE PROCEDURE sp_remove_group(
    IN _group_id INT UNSIGNED
)
BEGIN
    -- delete the row with the specified group_id
    DELETE FROM category_groups
        WHERE group_id = _group_id;
    
    -- check if the deletion was successful (using ROW_COUNT)
    IF ROW_COUNT() = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Group ID not found.';
    END IF;
END;

