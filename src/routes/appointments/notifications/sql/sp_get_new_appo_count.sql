DROP PROCEDURE IF EXISTS sp_get_new_appo_count;

CREATE PROCEDURE sp_get_new_appo_count(
    IN _session JSON
)
BEGIN    
    -- variables
    DECLARE last_tracked_ BIGINT;
    DECLARE user_id_ INT UNSIGNED;
    DECLARE role_ VARCHAR(20);
    DECLARE now_ BIGINT DEFAULT UNIX_TIMESTAMP();

    -- fetch user id 
    CALL sp_get_user_id_role(_session, user_id_, role_);

    -- fetch last tracked time of user
    SELECT time
        INTO last_tracked_
        FROM appos_trackers
        WHERE user_id = user_id_;

    -- check null
    IF last_tracked_ IS NULL
    THEN 
        SET last_tracked_ = now_;
        INSERT INTO appos_trackers (user_id, time)
            VALUES (user_id_, now_);

    END IF;

    -- return new appointment count
    SELECT COUNT(*) 
        FROM appo_notifications             
        WHERE time >= last_tracked_;

END;