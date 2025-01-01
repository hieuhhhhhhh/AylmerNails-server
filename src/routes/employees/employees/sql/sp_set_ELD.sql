-- ELD = employee's last date

DROP PROCEDURE IF EXISTS sp_set_ELD;

CREATE PROCEDURE sp_set_ELD(
    IN  _employee_id INT UNSIGNED, 
    IN  _last_date BIGINT
)
BEGIN
    DECLARE exit HANDLER FOR SQLEXCEPTION
        ROLLBACK;  -- Rollback in case of an error

    -- Start the transaction
    START TRANSACTION;

        -- Check if the employee exists
        IF NOT EXISTS (SELECT 1 FROM employees WHERE employee_id = _employee_id) THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Invalid employee_id, no such employee exists';
        END IF;

        -- Update the last_date for the given employee_id
        UPDATE employees
            SET last_date = _last_date
            WHERE employee_id = _employee_id;

        -- Call sp_find_ELD_conflicts to find any appointments that conflict the update
        CALL sp_find_ELD_conflicts(_employee_id);

        -- Commit the transaction if all operations are successful
    COMMIT;
END;
