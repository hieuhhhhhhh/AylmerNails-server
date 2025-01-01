-- to be continued

DROP FUNCTION IF EXISTS fn_find_conflicting_length;

CREATE FUNCTION fn_find_conflicting_length(
    _service_id INT UNSIGNED,
    _employee_id INT UNSIGNED,
    _date BIGINT,  -- Unix timestamp (BIGINT)
    _start_time INT,  -- Appointment start time
    _end_time INT,  -- Appointment end time
    _selected_AOSO JSON -- list of selected add-on-service options for the selected service
)
RETURNS INT UNSIGNED
DETERMINISTIC
BEGIN

END;
