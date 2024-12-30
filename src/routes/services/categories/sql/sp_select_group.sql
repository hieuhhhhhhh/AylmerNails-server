DROP PROCEDURE IF EXISTS sp_select_group;

CREATE PROCEDURE sp_select_group(
    IN _category_id INT UNSIGNED, 
    IN _group_id INT UNSIGNED
)
BEGIN
    IF NOT EXISTS (SELECT 1 FROM categories WHERE category_id = _category_id) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid category_id, no such category exists';
    END IF;

    -- Update the group_id for the given category_id
    UPDATE categories
    SET group_id = _group_id
    WHERE category_id = _category_id;
END;

