CREATE PROCEDURE sp_add_phone_num_tokens(
    IN _phone_num_id INT UNSIGNED,
    IN _phone_num VARCHAR(30)
)
sp:BEGIN
    -- variables
    DECLARE i INT DEFAULT (CHAR_LENGTH(_phone_num) - 1);
    DECLARE token_ VARCHAR(30);
    DECLARE length_ INT DEFAULT CHAR_LENGTH(_phone_num); 


    -- add tokens from all characters except the first and last character
    WHILE i > 1 DO 
        -- fetch token
        SET token_ = SUBSTRING(_phone_num, i, length_);
        SET i = i - 1;

        -- insert token
        INSERT IGNORE INTO phone_num_tokens (token, phone_num_id)
            VALUES (token_, _phone_num_id);
    END WHILE;
END;