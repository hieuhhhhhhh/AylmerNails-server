DROP PROCEDURE IF EXISTS insert_authentication;

CREATE PROCEDURE insert_authentication(
    IN phone_num VARCHAR(15),
    IN hashed_password VARCHAR(60)
) BEGIN -- Insert a new record into the authentication table
INSERT INTO
    authentication (phone_number, hashed_password)
VALUES
    (phone_num, hashed_password);

END