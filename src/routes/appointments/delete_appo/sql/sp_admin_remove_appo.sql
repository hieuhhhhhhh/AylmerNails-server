DROP PROCEDURE IF EXISTS sp_admin_remove_appo;

CREATE PROCEDURE sp_admin_remove_appo(
    IN _session JSON,
    IN _appo_id INT UNSIGNED
)
sp:BEGIN
    -- validate session token
    CALL sp_validate_admin(_session);

    -- store appointment in canceled table
    CALL sp_store_canceled_appo(_appo_id, fn_session_to_user_id(_session));

    -- remove appointment
    DELETE 
        FROM appo_details
        WHERE appo_id = _appo_id;
END;

