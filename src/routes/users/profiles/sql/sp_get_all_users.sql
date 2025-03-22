DROP PROCEDURE IF EXISTS sp_get_all_users;

CREATE PROCEDURE sp_get_all_users(
    IN _session JSON,
    IN _limit INT
)
BEGIN    
    -- variables
    DECLARE user_id_ INT UNSIGNED;
    
    -- validate session token
    CALL sp_validate_admin(_session);    

    -- return all users with limit
    SELECT a.role, a.created_at, pn.value, p.first_name, p.last_name, p.notes
        FROM authentication a
            LEFT JOIN phone_numbers pn
                ON pn.phone_num_id = a.phone_num_id
            LEFT JOIN profiles p
                ON p.user_id = a.user_id            
        ORDER BY a.created_at DESC
        LIMIT _limit;

    -- fetch user's id
    SET user_id_ = fn_session_to_user_id(_session);

    -- return user's last track 
    SELECT time
        FROM users_trackers
        WHERE user_id = user_id_;

    -- -- update user's last track
    -- UPDATE users_trackers
    --     SET time = now_
    --     WHERE user_id = user_id_;

END;