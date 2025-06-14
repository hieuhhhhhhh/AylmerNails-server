DROP PROCEDURE IF EXISTS sp_delele_service;

CREATE PROCEDURE sp_delele_service(
    IN _session JSON,
    IN _service_id INT UNSIGNED
)
BEGIN
    -- validate session token
    CALL sp_validate_admin(_session);    
    
    -- delete record
    DELETE services
        WHERE service_id = _service_id
            AND last_date <= UNIX_TIMESTAMP();
END;