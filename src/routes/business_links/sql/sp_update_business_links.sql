DROP PROCEDURE IF EXISTS sp_update_business_links;

CREATE PROCEDURE sp_update_business_links(    
    IN _links JSON
)
BEGIN
    -- placeholders
    DECLARE i INT DEFAULT 0;
    DECLARE id_ INT UNSIGNED;
    DECLARE name_ VARCHAR(300);
    DECLARE value_ VARCHAR(500);

    -- iterate every slot from a json array
    WHILE i < JSON_LENGTH(_links) DO
        -- fetch employee_id
        SET id_ = JSON_UNQUOTE(JSON_EXTRACT(_links, CONCAT('$[', i, ']')));
        SET i = i + 1;

        -- fetch name
        SET name_ = JSON_UNQUOTE(JSON_EXTRACT(_links, CONCAT('$[', i, ']')));
        SET i = i + 1;

        -- fetch value
        SET value_ = JSON_UNQUOTE(JSON_EXTRACT(_links, CONCAT('$[', i, ']')));
        SET i = i + 1;

        -- update link
        UPDATE business_links
            SET name = name_,
                value = value_
            WHERE link_id = id_;

        -- end body
    END WHILE;

END;