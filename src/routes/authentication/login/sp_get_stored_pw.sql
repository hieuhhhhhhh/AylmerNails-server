DROP PROCEDURE IF EXISTS get_stored_pw;

CREATE PROCEDURE get_stored_pw(IN phone_num VARCHAR(15))
BEGIN
    SELECT user_id, hashed_password
    FROM authentication
    WHERE phone_number = phone_num;
END;

