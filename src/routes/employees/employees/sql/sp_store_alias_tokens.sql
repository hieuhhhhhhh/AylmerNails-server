DROP PROCEDURE IF EXISTS sp_store_alias_tokens;

CREATE PROCEDURE sp_store_alias_tokens(
    IN _employee_id INT UNSIGNED,
    IN _alias_tokens JSON
)
BEGIN
    -- index to iterate json array
    DECLARE i INT DEFAULT 0;

    -- placeholder
    DECLARE token_ VARCHAR(50);

    -- clear any old data
    DELETE FROM employee_alias_tokens
        WHERE employee_id = _employee_id;

    -- start iterating to fetch all tokens from the JSON array
    WHILE i < JSON_LENGTH(_alias_tokens) DO 
        -- fetch prompt of AOS
        SET token_ = JSON_UNQUOTE(JSON_EXTRACT(_alias_tokens, CONCAT('$[', i, ']')));
        SET i = i + 1;

        -- call the sp that hanlde adding AOS options
        INSERT IGNORE INTO employee_alias_tokens(token, employee_id)
            VALUES (token_, _employee_id);

        -- end loop
    END WHILE;
END;