DROP PROCEDURE IF EXISTS sp_sign_up;

CREATE PROCEDURE sp_sign_up(
    IN phone_num VARCHAR(15),
    IN hashed_password VARCHAR(60)
) BEGIN
INSERT INTO
    authentication (phone_number, hashed_password, created_at)
VALUES
    (phone_num, hashed_password, UNIX_TIMESTAMP());

END;