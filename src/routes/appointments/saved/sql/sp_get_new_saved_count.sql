DROP PROCEDURE IF EXISTS sp_get_new_saved_count;

CREATE PROCEDURE sp_get_new_saved_count(
    IN _session JSON
)
BEGIN    
    -- variables
    DECLARE last_tracked_ BIGINT;
    DECLARE user_id_ INT UNSIGNED;
    DECLARE now_ BIGINT DEFAULT UNIX_TIMESTAMP();

    -- validate session token
    CALL sp_validate_admin(_session);    

    -- fetch user's id
    SET user_id_ = fn_session_to_user_id(_session);

    -- fetch last tracked time of user
    SELECT time
        INTO last_tracked_
        FROM saved_trackers
        WHERE user_id = user_id_;

    -- check null
    IF last_tracked_ IS NULL
    THEN 
        SET last_tracked_ = now_;
        INSERT INTO saved_trackers (user_id, time)
            VALUES (user_id_, now_);

    END IF;

    -- return new appointment count
    SELECT COUNT(*) 
        FROM saved_appos             
        WHERE time >= last_tracked_;

END;