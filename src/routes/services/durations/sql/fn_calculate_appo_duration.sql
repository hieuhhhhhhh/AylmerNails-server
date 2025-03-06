DROP FUNCTION IF EXISTS fn_calculate_appo_duration;

CREATE FUNCTION fn_calculate_appo_duration(
    _appo_id INT UNSIGNED
)
RETURNS INT
DETERMINISTIC
BEGIN
    -- variables
    DECLARE service_id_ INT UNSIGNED;
    DECLARE emp_id_ INT UNSIGNED;
    DECLARE AOSOs_ JSON;
    
    -- fetch appointment info from appo_id
    SELECT service_id, employee_id, selected_AOSO
        INTO service_id_, emp_id_, AOSOs_
        FROM appo_details
        WHERE appo_id = _appo_id;

    -- calculate and return result
    RETURN fn_calculate_duration(service_id_, emp_id_, AOSOs_)
END;

