DROP PROCEDURE IF EXISTS sp_get_employees;

CREATE PROCEDURE sp_get_employees(
    IN _date BIGINT
)
BEGIN
    SELECT employee_id, alias, last_date
        FROM employees
        WHERE last_date IS NULL 
            OR last_date >= _date;
END;

