DROP PROCEDURE IF EXISTS sp_generate_salt;

CREATE PROCEDURE sp_generate_salt(
    IN _session_id INT UNSIGNED,
    OUT _session_salt INT
)
BEGIN
    -- generate a new salt
    SET _session_salt = FLOOR(RAND() * 1000000000);
    
    -- write a new salt and store it on unconfirmed table
    INSERT INTO unconfirmed_salts (session_id, new_salt)
    VALUES (_session_id, _session_salt);
END;