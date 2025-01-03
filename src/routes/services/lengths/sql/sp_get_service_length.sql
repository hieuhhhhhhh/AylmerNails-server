DROP PROCEDURE IF EXISTS sp_get_service_length;

CREATE PROCEDURE sp_get_service_length(
    IN _service_id INT UNSIGNED,
    IN _employee_id INT UNSIGNED,
    IN _date BIGINT,  -- Unix timestamp (BIGINT)
    IN _selected_AOSO JSON, -- list of selected add-on-service options for the selected service
    OUT _service_length_id INT UNSIGNED,
    OUT _length INT
)
BEGIN
    -- index to iterate json array
    DECLARE i TINYINT DEFAULT 0;

    -- other place holders
    DECLARE offset_ INT;
    DECLARE AOS_id_ INT UNSIGNED;
    DECLARE option_id_ INT UNSIGNED;

    -- fetch service's default length and its id
    SELECT service_length_id, length
        INTO _service_length_id, _length
        FROM service_lengths
        WHERE service_id = _service_id
            AND effective_from <= _date
        ORDER BY effective_from DESC
        LIMIT 1;

    -- fetch and merge offset of employee to current length
    SET offset_ = 0;
    SELECT length_offset
        INTO offset_
        FROM SLVs
        WHERE service_length_id = _service_length_id
            AND employee_id = _employee_id
        LIMIT 1;

    SET _length = _length + offset_;

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

        SET _length = _length + offset_;

        -- end loop
    END WHILE;

END;
