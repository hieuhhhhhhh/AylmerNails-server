DROP PROCEDURE IF EXISTS sp_add_category;

CREATE PROCEDURE sp_add_category(
    IN _session JSON,
    IN _name VARCHAR(50)
)
BEGIN
    -- validate session token
    CALL sp_validate_admin(_session);

    -- Insert the new category into the categories table
    INSERT INTO categories (name)
        VALUES (_name);

    -- update category order value
    UPDATE categories 
        SET sort_order = LAST_INSERT_ID()
        WHERE category_id = LAST_INSERT_ID();
    
    -- Optionally, you could return the last inserted ID
    SELECT LAST_INSERT_ID();
END; 

