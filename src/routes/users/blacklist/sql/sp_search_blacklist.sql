DROP PROCEDURE IF EXISTS sp_search_blacklist;

CREATE PROCEDURE sp_search_blacklist(
    IN _session JSON,
    IN _query VARCHAR(200),
    IN _type VARCHAR(200),
    IN _limit INT
)
BEGIN    
    -- variables
    DECLARE token_ VARCHAR(200);

    -- validate admin
    CALL sp_validate_admin(_session);

    -- return appointment notifications with limit
    IF _type = "empty" THEN
        -- return users match the query
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
            ORDER BY bl.time DESC
            LIMIT _limit;
    END IF;      


    -- return appointment notifications with limit
    IF _type = "phone number" THEN
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
                LEFT JOIN phone_num_tokens pt
                    ON pt.phone_num_id = bl.phone_num_id
            WHERE pt.token LIKE CONCAT(_query , '%')
            ORDER BY bl.time DESC
            LIMIT _limit;
    END IF;

    
    -- return appointment notifications with limit
    IF _type = "name" THEN
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
                LEFT JOIN name_tokens nt
                    ON nt.phone_num_id = bl.phone_num_id
            WHERE nt.token LIKE CONCAT(_query , '%')
            ORDER BY bl.time DESC
            LIMIT _limit;
    END IF;


    -- return appointment notifications with limit
    SET token_  =  SUBSTRING_INDEX(_query, ' ', 1);

    IF _type = "name with spaces" THEN
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
                LEFT JOIN name_tokens nt
                    ON nt.phone_num_id = bl.phone_num_id
            WHERE nt.token = token_
                AND
                    (ct.name LIKE CONCAT('%', _query, '%')
                    OR  CONCAT(p.first_name, ' ', p.last_name) LIKE CONCAT('%', _query, '%'))
            ORDER BY bl.time DESC
            LIMIT _limit;
    END IF;
END;