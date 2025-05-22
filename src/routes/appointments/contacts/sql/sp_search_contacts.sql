DROP PROCEDURE IF EXISTS sp_search_contacts;

CREATE PROCEDURE sp_search_contacts(
    IN _session JSON,
    IN _query VARCHAR(200)
)
BEGIN
    -- validate admin
    CALL sp_validate_admin(_session);

    -- return any contacts match the compared value
    SELECT DISTINCT p.value, c.phone_num_id, c.name, c.time, pr.first_name, pr.last_name
        FROM phone_numbers p
            JOIN contacts c
                ON c.phone_num_id = p.phone_num_id
            JOIN contact_tokens ct
                ON ct.phone_num_id = p.phone_num_id
            LEFT JOIN authentication au
                ON au.phone_num_id = p.phone_num_id
            LEFT JOIN profiles pr
                ON pr.user_id = au.user_id
        WHERE p.value LIKE CONCAT('%', _query , '%')
            OR ct.token LIKE CONCAT(_query , '%')
        ORDER BY c.time DESC
        LIMIT 30;
END;
