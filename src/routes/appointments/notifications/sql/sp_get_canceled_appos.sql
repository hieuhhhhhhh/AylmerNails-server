DROP PROCEDURE IF EXISTS sp_get_canceled_appos;

CREATE PROCEDURE sp_get_canceled_appos(
    IN _session JSON,
    IN _limit INT
)
BEGIN    
    -- variables
    DECLARE user_id_ INT UNSIGNED;
    
    -- validate session token
    CALL sp_validate_admin(_session);    

    -- return appointment notifications with limit
    SELECT c.canceled_id, c.user_id, c.details, c.time, p.first_name, p.last_name, pn.value
        FROM canceled_appos c
            LEFT JOIN profiles p
                ON p.user_id = c.user_id
            LEFT JOIN authentication a
                ON a.user_id = c.user_id
            LEFT JOIN phone_numbers pn
                ON pn.phone_num_id = a.phone_num_id
        ORDER BY time DESC
        LIMIT _limit;

    -- fetch user's id
    SET user_id_ = fn_session_to_user_id(_session);

    -- return user's last track 
    SELECT time
        FROM canceled_trackers
        WHERE user_id = user_id_;

    -- -- update user's last track
    -- UPDATE appos_trackers
    --     SET time = now_
    --     WHERE user_id = user_id_;

END;
