DROP PROCEDURE IF EXISTS sp_search_users;

CREATE PROCEDURE sp_search_users(
    IN _query VARCHAR(200),
    IN _limit INT
)
BEGIN    
    -- return users match the query
    SELECT a.user_id, a.phone_num_id, pn.value, a.role, p.first_name, p.last_name, a.created_at, c.name     
        FROM authentication a
            LEFT JOIN phone_numbers pn
                ON pn.phone_num_id = a.phone_num_id
            LEFT JOIN profiles p
                ON p.user_id = a.user_id
            LEFT JOIN contacts c
                ON c.phone_num_id = a.phone_num_id
        WHERE pn.value LIKE CONCAT('+1', _query , '%')
            OR p.first_name LIKE CONCAT(_query , '%')
            OR p.last_name LIKE CONCAT(_query , '%')
        ORDER BY a.created_at DESC
        LIMIT _limit;
END;