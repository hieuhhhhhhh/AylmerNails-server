DROP PROCEDURE IF EXISTS sp_get_bookings_last_tracked;

CREATE PROCEDURE sp_get_bookings_last_tracked(
    IN _session JSON
)
BEGIN    
    -- variables
    DECLARE user_id_ INT UNSIGNED;
        
    -- validate session token
    CALL sp_validate_admin(_session);    

    -- fetch user's id
    SET user_id_ = fn_session_to_user_id(_session);

    -- return user's last track 
    SELECT time
        FROM appos_trackers
        WHERE user_id = user_id_;

    -- -- update user's last track
    -- UPDATE users_trackers
    --     SET time = now_
    --     WHERE user_id = user_id_;

END;