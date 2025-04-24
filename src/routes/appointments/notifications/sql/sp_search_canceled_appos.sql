DROP PROCEDURE IF EXISTS sp_search_canceled_appos;

CREATE PROCEDURE sp_search_canceled_appos(
    IN _session JSON,
    IN _query VARCHAR(200),
    IN _limit INT
)
BEGIN    
    -- validate admin
    CALL sp_validate_admin(_session);

    -- return appointment notifications with limit
    SELECT c.canceled_id, c.user_id, c.details, c.time, p.first_name, p.last_name, pn.value
        FROM canceled_appos c
            LEFT JOIN profiles p
                ON p.user_id = c.user_id
            LEFT JOIN authentication a
                ON a.user_id = c.user_id
            LEFT JOIN phone_numbers pn
                ON pn.phone_num_id = a.phone_num_id
        WHERE pn.value LIKE CONCAT('+1', _query , '%')
            OR p.first_name LIKE CONCAT(_query , '%')
            OR p.last_name LIKE CONCAT(_query , '%')        
        ORDER BY c.time DESC
        LIMIT _limit;
END;
