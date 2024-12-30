DROP PROCEDURE IF EXISTS sp_add_service;

CREATE PROCEDURE sp_add_service(
    IN _name VARCHAR(50),
    IN _category_id INT UNSIGNED,
)
BEGIN
    -- Insert the new category into the categories table
    INSERT INTO categories (name, category_id)
        VALUES (_name, _category_id);
    
    -- Optionally, you could return the last inserted ID
    SELECT LAST_INSERT_ID();
END; 

