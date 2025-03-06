DROP PROCEDURE IF EXISTS sp_add_service_length;

CREATE PROCEDURE sp_add_service_length(
    IN _session JSON,
    IN _service_id INT UNSIGNED,    
    IN _default_duration INT,
    IN _durations JSON 
)
BEGIN
    DECLARE emp_id_ INT UNSIGNED;
    DECLARE duration_ INT;

    -- validate session token
    CALL sp_validate_admin(_session);

    -- update default duration
    UPDATE services 
        SET duration = _duration
        WHERE service_id = _service_id;

    -- remove old employee durations
    DELETE 
        FROM durations
        WHERE service_id = _service_id;

    -- update employee durations
    WHILE i < JSON_LENGTH(_durations) DO 
        -- fetch emp id on next index
        SET emp_id_ = JSON_UNQUOTE(JSON_EXTRACT(_durations, CONCAT('$[', i, ']')));
        SET i = i + 1;

        -- fetch duration on next index
        SET duration_ = JSON_UNQUOTE(JSON_EXTRACT(_durations, CONCAT('$[', i, ']')));
        SET i = i + 1;

        -- create new employee duration
        INSERT INTO durations (service_id, employee_id, duration)
            VALUES (_service_id, emp_id_, duration_);
 
        -- end loop
    END WHILE;

    -- scan duration conflicts
    CALL sp_scan_duration_conflicts(_service_id);
END;