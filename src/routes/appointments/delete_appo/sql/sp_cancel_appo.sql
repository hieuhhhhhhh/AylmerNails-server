DROP PROCEDURE IF EXISTS sp_cancel_appo;

CREATE PROCEDURE sp_cancel_appo(
    IN _session JSON,
    IN _appo_id INT UNSIGNED
)
sp:BEGIN
    -- validate session token
    CALL sp_validate_client(_session);

    -- check if appointment is matching with session 
    IF EXISTS (
        SELECT 1
            FROM appo_details
            WHERE appo_id = _appo_id
                AND phone_num_id = fn_session_to_phone_num_id(_session)
    )
    THEN
        -- store appointment in canceled table
        CALL sp_store_canceled_appo(_appo_id, fn_session_to_user_id(_session));

        -- remove appointment in main table
        DELETE 
            FROM appo_details
            WHERE appo_id = _appo_id;
    END IF;

END;

