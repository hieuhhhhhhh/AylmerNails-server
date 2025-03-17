DROP PROCEDURE IF EXISTS sp_get_employees;

CREATE PROCEDURE sp_get_employees(
    IN _date BIGINT
)
BEGIN
    SELECT 
        e.employee_id, 
        e.alias, 
        e.last_date, 
        (e.last_date IS NULL OR e.last_date >= _date),
        c.code
            FROM employees e
                JOIN colors c
                    ON c.color_id = e.color_id;
END;

