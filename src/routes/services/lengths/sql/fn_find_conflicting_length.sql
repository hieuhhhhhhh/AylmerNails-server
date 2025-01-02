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
    DECLARE i TINYINT,

    -- other place holders
    DECLARE service_length_id_ INT UNSIGNED,
    DECLARE length_ INT,
    DECLARE offset_ INT,
    DECLARE AOS_id_ INT UNSIGNED,
    DECLARE option_id_ INT UNSIGNED,

    -- fetch service's default length and its id
    SELECT service_length_id, length
        INTO service_length_id_, length_
        FROM service_lengths
        WHERE service_id = _service_id
            AND effective_from <= UNIX_TIMESTAMP()
        ORDER BY effective_from DESC
        LIMIT 1;

    -- fetch and merge offset of employee to current length
    SET offset_ = 0;
    SELECT length_offset
        INTO offset_
        FROM SLVs
        WHERE service_length_id = service_length_id_
            AND employee_id = _employee_id
        LIMIT 1;

    SET length_ = length_ + offset_;

    -- iterate _selected_AOSO, fetch and merge offset of every AOSO 
    WHILE i < JSON_LENGTH(_selected_AOSO) DO 
        -- fetch every AOS_id_
        SET AOS_id_ = JSON_UNQUOTE(JSON_EXTRACT(_selected_AOSO, CONCAT('$[', i, ']')));
        SET i = i + 1;

        -- fetch the option id for that AOS
        SET option_id_ = JSON_UNQUOTE(JSON_EXTRACT(_selected_AOSO, CONCAT('$[', i, ']')));
        SET i = i + 1;

        -- fetch and merge offset of that option
        SET offset_ = 0;
    
        SELECT length_offset
            INTO offset_
            FROM AOS_options ao
                JOIN add_on_services aos
                ON aos.AOS_id = ao.AOS_id
            WHERE aos.service_id = _service_id
                AND ao.AOS_id = AOS_id_
                AND ao.option_id = option_id_
            LIMIT 1;

        SET length_ = length_ + offset_;

        -- end loop
    END WHILE;

    -- Return an service_length_id with which the appointment violates
    IF length_ = (_end_time - _start_time) THEN
        RETURN NULL;
    ELSE 
        RETURN service_length_id_;
    END IF;
END;
