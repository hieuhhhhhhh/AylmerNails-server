DROP PROCEDURE IF EXISTS sp_search_contacts;

CREATE PROCEDURE sp_search_contacts(
    IN _text VARCHAR(200)
)
BEGIN
    -- return any contacts match the compared value
    SELECT DISTINCT  p.value, c.phone_num_id, c.name 
        FROM phone_numbers p
            JOIN contacts c
                ON c.phone_num_id = p.phone_num_id
            JOIN contact_tokens ct
                ON ct.phone_num_id = p.phone_num_id
        WHERE p.value LIKE CONCAT(_text , '%')
            OR ct.token LIKE CONCAT(_text , '%')
        ORDER BY c.time DESC
        LIMIT 30;
END;
