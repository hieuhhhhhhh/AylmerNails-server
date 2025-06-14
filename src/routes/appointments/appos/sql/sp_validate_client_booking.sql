DROP PROCEDURE IF EXISTS sp_validate_client_booking;

CREATE PROCEDURE sp_validate_client_booking(
    IN _session JSON,
)
BEGIN
    -- validate session token
    CALL sp_validate_client(_session);

    -- return phone number id and booker id
    SELECT user_id, phone_num_id
        FROM authentication
        WHERE user_id = fn_session_to_user_id(_session);

END;

