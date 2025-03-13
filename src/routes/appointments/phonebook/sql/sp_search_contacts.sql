DROP PROCEDURE IF EXISTS sp_search_contacts;

CREATE PROCEDURE sp_search_contacts(
    IN _phone_num VARCHAR(15),
)
BEGIN
    SELECT * 
        FROM phone_numbers p
            JOIN contacts c
        WHERE p.value LIKE CONCAT(_phone_num, '%')
        ORDER BY c.time DESC
        LIMIT 30;
END;
