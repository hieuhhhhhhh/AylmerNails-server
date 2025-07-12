DROP PROCEDURE IF EXISTS sp_delete_service;

CREATE PROCEDURE sp_delete_service(
    IN _session JSON,
    IN _service_id INT UNSIGNED
)
BEGIN
    -- validate session token
    CALL sp_validate_admin(_session);    
    
    -- delete record
    DELETE FROM services
        WHERE service_id = _service_id
            AND last_date <= UNIX_TIMESTAMP();
END;