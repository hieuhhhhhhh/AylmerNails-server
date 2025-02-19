DROP PROCEDURE IF EXISTS sp_get_appo_length;

CREATE PROCEDURE sp_get_appo_length(
    IN _service_id INT UNSIGNED,
    IN _employee_id INT UNSIGNED,
    IN _date BIGINT,  -- Unix timestamp (BIGINT)
    IN _selected_AOSO JSON -- list of selected add-on-service options for the selected service    
)
BEGIN
    -- result holder
    DECLARE service_length_id_ INT UNSIGNED;
    DECLARE planned_length_ INT;

    -- process input
    CALL sp_calculate_length(_service_id, _employee_id, _date, _selected_AOSO, service_length_id_, planned_length_);

    -- return result
    SELECT planned_length_;
END;
