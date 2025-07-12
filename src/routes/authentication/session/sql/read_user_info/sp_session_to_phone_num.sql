DROP PROCEDURE IF EXISTS sp_session_to_phone_num;

CREATE PROCEDURE sp_session_to_phone_num(
    IN _session JSON
)
BEGIN
    SELECT pn.value
        FROM authentication a
            JOIN phone_numbers pn
        WHERE user_id = fn_session_to_user_id(_session);
END;