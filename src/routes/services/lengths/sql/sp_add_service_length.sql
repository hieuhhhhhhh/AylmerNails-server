DROP PROCEDURE IF EXISTS sp_add_service_length;

CREATE PROCEDURE sp_add_service_length(
    IN _session JSON,
    IN _service_id INT UNSIGNED,
    IN _effective_from BIGINT,
    IN _length INT,
    IN _SLVs JSON -- a json array that contain data of all SLVs of this service length (SLVs = service length variations) 
)
BEGIN
    -- index to iterate json array
    DECLARE i TINYINT DEFAULT 0;

    -- other place holders
    DECLARE user_id_ INT UNSIGNED;
    DECLARE role_ VARCHAR(20);
    DECLARE service_length_id_ INT UNSIGNED;
    DECLARE employee_id_ INT UNSIGNED;
    DECLARE length_offset_ INT;

    -- fetch and validate user's role from session data
    CALL sp_get_user_id_role(_session, user_id_, role_);

    -- IF role is not valid return null and leave procedure
    IF role_ IS NULL
        OR role_ NOT IN ('admin', 'developer')
    THEN 
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '401, Unauthorized';
    END IF;

    -- delete any old service_length that has same effective_from
    DELETE FROM service_lengths
        WHERE service_id = _service_id  
            AND effective_from = _effective_from;

    -- create new service length
    INSERT INTO service_lengths (service_id, effective_from, length)
        VALUES (_service_id, _effective_from, _length);

    -- fetch id of new service_length
    SET service_length_id_ = LAST_INSERT_ID();

    -- start iterating to fetch variations from the JSON array
    WHILE i < JSON_LENGTH(_SLVs) DO 
        -- fetch id of the owner of this variation
        SET employee_id_ = JSON_UNQUOTE(JSON_EXTRACT(_SLVs, CONCAT('$[', i, ']')));
        SET i = i + 1;

        -- fetch the offset value of this variation
        SET length_offset_ = JSON_UNQUOTE(JSON_EXTRACT(_SLVs, CONCAT('$[', i, ']')));
        SET i = i + 1;

        -- Insert the new variations into the SLVs table
        INSERT INTO SLVs (service_length_id, employee_id, length_offset)
            VALUES (service_length_id_, employee_id_, length_offset_);
        
        -- end loop
    END WHILE;

    -- return added service_length_id
    SELECT service_length_id_;

END; 

