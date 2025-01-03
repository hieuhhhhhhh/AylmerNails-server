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

    -- Exception handling to roll back in case of an error
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
        ROLLBACK; -- rollback transaction

    -- Start the transaction
    START TRANSACTION;

        -- delete any old service_length that has same effective_from
        DELETE FROM service_lengths
            WHERE servide_id = _service_id  
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

     -- Commit the transaction if everything went well
    COMMIT;
END; 

