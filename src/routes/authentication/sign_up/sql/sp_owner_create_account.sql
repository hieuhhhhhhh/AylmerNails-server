DROP PROCEDURE IF EXISTS sp_owner_create_account;

CREATE PROCEDURE sp_owner_create_account(
    IN _session JSON,
    IN _phone_num VARCHAR(15),
    IN _hashed_password VARCHAR(60),
    IN _first_name VARCHAR(30),
    IN _last_name VARCHAR(30)
) 
BEGIN
    -- validate session token
    CALL sp_validate_owner(_session);

    -- add user
    CALL sp_add_user(_phone_num, _hashed_password, _first_name, _last_name);
END;
