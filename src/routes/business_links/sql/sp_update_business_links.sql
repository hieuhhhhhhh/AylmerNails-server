DROP PROCEDURE IF EXISTS sp_update_business_links;

CREATE PROCEDURE sp_update_business_links(    
    IN _session JSON,
    IN _links JSON
)
BEGIN
    -- placeholders
    DECLARE i INT DEFAULT 0;
    DECLARE link_id_ ENUM('phone_number', 'google_map', 'instagram', 'email');
    DECLARE details_ JSON;

    -- validate session token
    CALL sp_validate_admin(_session);

    -- iterate every slot from a json array
    WHILE i < JSON_LENGTH(_links) DO
        -- fetch employee_id
        SET link_id_ = JSON_UNQUOTE(JSON_EXTRACT(_links, CONCAT('$[', i, ']')));
        SET i = i + 1;

        -- fetch details
        SET details_ = JSON_UNQUOTE(JSON_EXTRACT(_links, CONCAT('$[', i, ']')));
        SET i = i + 1;

        -- update link
        UPDATE business_links
            SET details = details_
            WHERE link_id = link_id_;

        -- end body
    END WHILE;

END;