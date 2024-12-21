DROP PROCEDURE IF EXISTS add_session;


CREATE PROCEDURE add_session(IN _user_id INT)
BEGIN
    DECLARE session_salt_ INT;

    -- Generate a random session_salt 
    SET session_salt_ = FLOOR(RAND() * 1000000);  

    -- Insert the new session into the user_sessions table
    INSERT INTO user_sessions (session_salt, user_id, created_at)
    VALUES (session_salt_, _user_id, UNIX_TIMESTAMP());

    -- Select the last inserted id and the generated session_salt
    SELECT LAST_INSERT_ID() AS session_id, session_salt_ AS session_salt;
END;

