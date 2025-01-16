DROP PROCEDURE IF EXISTS sp_get_all_employees;

CREATE PROCEDURE sp_get_all_employees()
BEGIN
    SELECT employee_id, alias, first_date, last_date
        FROM employees;
END;
