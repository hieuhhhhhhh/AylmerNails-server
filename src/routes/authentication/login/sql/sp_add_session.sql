DROP PROCEDURE IF EXISTS sp_add_session;

CREATE PROCEDURE sp_add_session(IN _user_id INT)
BEGIN
    -- Insert the new session into the user_sessions table
    INSERT INTO user_sessions (user_id, created_at)
    VALUES (_user_id, UNIX_TIMESTAMP());
    -- Select the last inserted id
    SELECT LAST_INSERT_ID() AS session_id;
END;