DROP PROCEDURE IF EXISTS sp_store_name_tokens;

CREATE PROCEDURE sp_store_name_tokens(
    IN _service_id INT UNSIGNED,
    IN _service_name_tokens JSON
)
BEGIN
    -- index to iterate json array
    DECLARE i INT DEFAULT 0;

    -- placeholder
    DECLARE token_ VARCHAR(50);

    -- clear any old data
    DELETE FROM service_name_tokens
        WHERE service_id = _service_id;

    -- start iterating to fetch all tokens from the JSON array
    WHILE i < JSON_LENGTH(_service_name_tokens) DO 
        -- fetch prompt of AOS
        SET token_ = JSON_UNQUOTE(JSON_EXTRACT(_service_name_tokens, CONCAT('$[', i, ']')));
        SET i = i + 1;

        -- call the sp that hanlde adding AOS options
        INSERT IGNORE INTO service_name_tokens(token, service_id)
            VALUES (token_, _service_id);

        -- end loop
    END WHILE;
END;