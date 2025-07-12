CREATE PROCEDURE sp_update_name_tokens(
    IN _phone_num_id INT UNSIGNED
)
sp:BEGIN
    -- variables
    DECLARE first_name_ VARCHAR(200);
    DECLARE last_name_ VARCHAR(200);
    DECLARE contact_name_ VARCHAR(200);

    -- remove old tokens
    DELETE FROM name_tokens
        WHERE phone_num_id = _phone_num_id;

    -- fetching
    SELECT first_name, last_name
        INTO first_name_, last_name_
        FROM profiles p
            JOIN authentication a
                ON p.user_id = a.user_id
        WHERE a.phone_num_id = _phone_num_id;

    SELECT name 
        INTO contact_name_
        FROM contacts
        WHERE phone_num_id = _phone_num_id;

    -- start tokenizing
    CALL sp_tokenize_name(first_name_, _phone_num_id);
    CALL sp_tokenize_name(last_name_, _phone_num_id);
    CALL sp_tokenize_name(contact_name_, _phone_num_id);

END;

CREATE PROCEDURE sp_tokenize_name(
    IN _name VARCHAR(200),
    IN _phone_num_id INT UNSIGNED
)
sp:BEGIN
    -- variables
    DECLARE i INT;
    DECLARE left_ VARCHAR(200);
    DECLARE right_ VARCHAR(200) DEFAULT _name;

    -- tokenize
    WHILE CHAR_LENGTH(right_) > 0 DO 
        -- fetch token
        SET i = LOCATE(' ', right_);
        
        -- if no space i is last index
        IF i = 0 THEN
            SET i = CHAR_LENGTH(right_) + 1;
        END IF;

        -- fetch left side from i
        SET left_ = SUBSTRING(right_, 1, i-1);

        -- fetch the other half
        SET right_ = SUBSTRING(right_, i+1);

        -- insert left side as token
        IF CHAR_LENGTH(left_) > 0 THEN
            INSERT IGNORE INTO name_tokens (token, phone_num_id)
                VALUES (left_, _phone_num_id);
        END IF;
    END WHILE;
END;

