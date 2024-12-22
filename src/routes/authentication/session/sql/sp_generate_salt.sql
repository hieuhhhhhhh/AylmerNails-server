DROP PROCEDURE IF EXISTS sp_generate_salt;

CREATE PROCEDURE sp_generate_salt(
    IN _session_id INT UNSIGNED,
    OUT _session_salt INT
)
BEGIN
    -- generate a new salt
    DECLARE new_salt_ INT DEFAULT FLOOR(RAND() * 1000000000);
    SET _session_salt = new_salt_;
    
    -- write a new salt, update if session_id already exists
    INSERT INTO unconfirmed_salts (session_id, new_salt)
    VALUES (_session_id, new_salt_)
    ON DUPLICATE KEY UPDATE new_salt = new_salt_;
END;
