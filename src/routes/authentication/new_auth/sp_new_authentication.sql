DROP PROCEDURE IF EXISTS sp_new_authentication;

CREATE PROCEDURE sp_new_authentication(
    IN _phone_number VARCHAR(15),
    IN _hashed_password VARCHAR(60)
) 
BEGIN
    INSERT INTO authentication (phone_number, hashed_password, created_at)
    VALUES (_phone_number, _hashed_password, UNIX_TIMESTAMP())
    ON DUPLICATE KEY UPDATE 
        hashed_password = _hashed_password, 
END;
