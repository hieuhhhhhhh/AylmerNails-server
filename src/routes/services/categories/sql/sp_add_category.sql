DROP PROCEDURE IF EXISTS sp_add_category;

CREATE PROCEDURE sp_add_category(
    IN _name VARCHAR(50),
)
BEGIN
    -- Insert the new category into the categories table
    INSERT INTO categories (name)
    VALUES (_name);
    
    -- Optionally, you could return the last inserted ID
    SELECT LAST_INSERT_ID();
END; 

