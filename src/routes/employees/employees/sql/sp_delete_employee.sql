DROP PROCEDURE IF EXISTS sp_delete_employee;

CREATE PROCEDURE sp_delete_employee(
    IN _session JSON,
    IN _employee_id INT UNSIGNED
)
BEGIN
    -- validate session token
    CALL sp_validate_admin(_session);    
    
    -- delete record
    DELETE FROM employees
        WHERE employee_id = _employee_id
            AND last_date <= UNIX_TIMESTAMP();

    -- return result
    SELECT ROW_COUNT();
END;