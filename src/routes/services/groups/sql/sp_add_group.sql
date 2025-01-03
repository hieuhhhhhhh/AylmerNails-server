DROP PROCEDURE IF EXISTS sp_add_group;

CREATE PROCEDURE sp_add_group(
    IN _name VARCHAR(50)
)
BEGIN
    -- Insert the new category into the categories table
    INSERT INTO category_groups (name)
        VALUES (_name);
    
    -- Optionally, you could return the last inserted ID
    SELECT LAST_INSERT_ID();
END; 

