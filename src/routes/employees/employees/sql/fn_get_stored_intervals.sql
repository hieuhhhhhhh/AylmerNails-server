CREATE FUNCTION get_stored_intervals(
    _employee_id INT UNSIGNED
) 
RETURNS JSON
DETERMINISTIC
BEGIN
    DECLARE stored_intervals_ JSON;

    -- Retrieve the stored_intervals JSON for the given employee_id
    SELECT stored_intervals
        INTO stored_intervals_
        FROM employees
        WHERE employee_id = _employee_id;

    -- Return the stored_intervals
    RETURN stored_intervals_;
END;

