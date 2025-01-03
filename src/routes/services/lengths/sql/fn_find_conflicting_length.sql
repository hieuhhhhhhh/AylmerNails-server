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
    -- index to iterate json array
    DECLARE i TINYINT DEFAULT 0;

    -- other place holders
    DECLARE service_length_id_ INT UNSIGNED;
    DECLARE length_ INT;
    DECLARE offset_ INT;
    DECLARE AOS_id_ INT UNSIGNED;
    DECLARE option_id_ INT UNSIGNED;

    -- get total length for this service by employee and selected AOSO
    CALL sp_get_service_length(
        _service_id, 
        _employee_id, 
        _date, 
        _selected_AOSO, 
        service_length_id_, 
        length_
    );

    -- Compare a service_length_id with which the appointment is conflicting
    IF length_ = (_end_time - _start_time) THEN
        RETURN NULL;
    ELSE 
        RETURN service_length_id_;
    END IF;
END;
