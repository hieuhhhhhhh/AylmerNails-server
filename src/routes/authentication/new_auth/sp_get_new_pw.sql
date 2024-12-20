CREATE PROCEDURE sp_get_new_pw(IN _phone_number VARCHAR(15))
BEGIN
    SELECT new_password
    FROM sms_verify_codes
    WHERE phone_number = _phone_number;
END