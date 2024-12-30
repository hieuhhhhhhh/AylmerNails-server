DROP PROCEDURE IF EXISTS sp_add_employee;

CREATE PROCEDURE sp_add_employee(
    IN _alias VARCHAR(50),
    IN first_date BIGINT,
)
BEGIN 
    -- Insert the new category into the categories table
    INSERT INTO employees (alias, first_date)
    VALUES (_alias, _first_date);
    
    -- Optionally, you could return the last inserted ID
    SELECT LAST_INSERT_ID();
END; 