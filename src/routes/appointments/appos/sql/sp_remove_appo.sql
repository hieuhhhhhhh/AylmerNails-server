DROP PROCEDURE IF EXISTS sp_remove_appo;

CREATE PROCEDURE sp_remove_appo(
    IN _session JSON,
    IN _appo_id INT UNSIGNED
)
sp:BEGIN
    -- validate session token
    CALL sp_validate_admin(_session);

    -- remove appointment by id
    DELETE 
        FROM appo_details
        WHERE appo_id = _appo_id;
END;

