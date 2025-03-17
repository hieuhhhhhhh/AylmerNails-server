DROP PROCEDURE IF EXISTS sp_store_contact_tokens;

CREATE PROCEDURE sp_store_contact_tokens(
    IN _phone_num_id INT UNSIGNED,
    IN _name_tokens JSON
)
BEGIN
    -- index to iterate json array
    DECLARE i INT DEFAULT 0;

    -- placeholder
    DECLARE token_ VARCHAR(50);


    -- clear any old data
    DELETE FROM contact_tokens
        WHERE phone_num_id = _phone_num_id;

    -- start iterating to fetch all tokens from the JSON array
    WHILE i < JSON_LENGTH(_name_tokens) DO 
    
        -- fetch prompt of AOS
        SET token_ = JSON_UNQUOTE(JSON_EXTRACT(_name_tokens, CONCAT('$[', i, ']')));
        SET i = i + 1;

        -- call the sp that hanlde adding AOS options
        INSERT IGNORE INTO contact_tokens (token, phone_num_id)
            VALUES (token_, _phone_num_id);

        -- end loop
    END WHILE;
END;