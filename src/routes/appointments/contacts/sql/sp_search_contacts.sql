DROP PROCEDURE IF EXISTS sp_search_contacts;

CREATE PROCEDURE sp_search_contacts(
    IN _phone_num VARCHAR(15)
)
BEGIN
    -- return any contacts match the compared value
    SELECT p.value, c.phone_num_id, c.name 
        FROM phone_numbers p
            JOIN contacts c
        WHERE p.value LIKE CONCAT(_phone_num, '%')
        ORDER BY c.time DESC
        LIMIT 30;
END;
