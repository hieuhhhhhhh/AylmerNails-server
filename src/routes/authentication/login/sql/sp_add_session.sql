DROP PROCEDURE IF EXISTS sp_add_session;

CREATE PROCEDURE sp_add_session(
    IN _user_id INT UNSIGNED,
    IN _expiry INT,
    IN _remember_me BOOLEAN
)
BEGIN
    DECLARE session_salt_ INT;
    
    -- Generate a random session_salt 
    SET session_salt_ = FLOOR(RAND() * 1000000000);
    
    -- Insert the new session into the user_sessions table
    INSERT INTO user_sessions ( session_salt, user_id, created_at, expiry, remember_me)
        VALUES (session_salt_, _user_id, UNIX_TIMESTAMP(), _expiry, _remember_me);
    
    -- remove login attempts
    DELETE FROM login_attempts
        WHERE user_id = _user_id;

    -- Select the last inserted id and the generated session_salt
    SELECT LAST_INSERT_ID() AS session_id, session_salt_ AS session_salt;
END;