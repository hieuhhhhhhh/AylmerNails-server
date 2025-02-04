DROP FUNCTION IF EXISTS fn_get_interval_percent;

CREATE FUNCTION fn_get_interval_percent(
    _employee_id INT UNSIGNED
) 
RETURNS SMALLINT
DETERMINISTIC
BEGIN
    DECLARE interval_percent_ SMALLINT;

    -- Retrieve the stored_intervals JSON for the given employee_id
    SELECT interval_percent
        INTO interval_percent_
        FROM employees
        WHERE employee_id = _employee_id;

    -- Return the stored_intervals
    RETURN interval_percent_;
END;

