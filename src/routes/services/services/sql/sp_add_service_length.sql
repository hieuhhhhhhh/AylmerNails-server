DROP PROCEDURE IF EXISTS sp_add_service_length;

CREATE PROCEDURE sp_add_service_length(
    IN _service_id INT UNSIGNED,
    IN _effective_from BIGINT,
    IN _length INT
)
BEGIN
    -- Insert a new row into the service_lengths table
    INSERT INTO service_lengths (service_id, effective_from, length)
        VALUES (p_service_id, _effective_from, _length);
END;

