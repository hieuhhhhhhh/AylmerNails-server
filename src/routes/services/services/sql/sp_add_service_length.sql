DROP PROCEDURE IF EXISTS sp_add_service_length;

CREATE PROCEDURE sp_add_service_length(
    IN _service_id INT UNSIGNED,
    IN _effective_from BIGINT,
    IN _length INT,
    IN _SLVs JSON -- a json array that contain data of all SLVs of this service length (SLVs = service length variations) 
)
BEGIN
    -- index to iterate json array
    DECLARE i TINYINT DEFAULT 0;

    -- other place holders
    DECLARE service_length_id_ INT UNSIGNED;
    DECLARE employee_id_ INT UNSIGNED;
    DECLARE length_offset_ INT;

    -- Insert the new service into the services table
    INSERT INTO service_lengths (service_id, effective_from, length)
        VALUES (_service_id, _effective_from, _length);

    -- fetch the newly added id
    SET service_length_id_ = LAST_INSERT_ID();

    -- start iterating to generate opening hours that reference the new schedule_id
    WHILE i < JSON_LENGTH(_SLVs) DO 
        SET employee_id_ = JSON_UNQUOTE(JSON_EXTRACT(_opening_times, CONCAT('$[', i, ']')));

        -- increment index
        SET i = i + 1;

        SET length_offset_ = JSON_UNQUOTE(JSON_EXTRACT(_closing_times, CONCAT('$[', i, ']')));

        -- Insert the new variations into the SLVs table
        INSERT INTO SLVs (service_length_id, employee_id, length_offset)
            VALUES (service_length_id_, employee_id_, length_offset_);

        -- increment index
        SET i = i + 1;
    END WHILE;
END; 

