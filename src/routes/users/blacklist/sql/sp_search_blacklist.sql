DROP PROCEDURE IF EXISTS sp_search_blacklist;

CREATE PROCEDURE sp_search_blacklist(
    IN _query VARCHAR(200),
    IN _limit INT
)
BEGIN    
    -- return saved appos with limit
    SELECT DISTINCT pn.value, bl.time, p.first_name, p.last_name, ct.name
        FROM blacklist bl
            LEFT JOIN authentication a
                ON a.phone_num_id = bl.phone_num_id
            LEFT JOIN profiles p
                ON p.user_id = a.user_id
            LEFT JOIN contacts ct
                ON ct.phone_num_id = bl.phone_num_id
            LEFT JOIN contact_tokens tk
                ON tk.phone_num_id = bl.phone_num_id
            LEFT JOIN phone_numbers pn
                ON pn.phone_num_id = bl.phone_num_id
        WHERE pn.value LIKE CONCAT('+1', _query , '%')
            OR tk.token LIKE CONCAT(_query , '%')
            OR p.first_name LIKE CONCAT(_query , '%')
            OR p.last_name LIKE CONCAT(_query , '%')        
        ORDER BY bl.time DESC
        LIMIT _limit;
END;