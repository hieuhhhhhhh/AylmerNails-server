DROP PROCEDURE IF EXISTS sp_search_users;

CREATE PROCEDURE sp_search_users(
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
        SELECT DISTINCT a.user_id, a.phone_num_id, pn.value, a.role, p.first_name, p.last_name, a.created_at, c.name     
            FROM authentication a
                LEFT JOIN phone_numbers pn
                    ON pn.phone_num_id = a.phone_num_id
                LEFT JOIN profiles p
                    ON p.user_id = a.user_id
                LEFT JOIN contacts c
                    ON c.phone_num_id = a.phone_num_id
            ORDER BY a.created_at DESC
            LIMIT _limit;
    END IF;      

    -- return appointment notifications with limit
    IF _type = "phone number" THEN
        SELECT DISTINCT a.user_id, a.phone_num_id, pn.value, a.role, p.first_name, p.last_name, a.created_at, c.name     
            FROM authentication a
                LEFT JOIN phone_numbers pn
                    ON pn.phone_num_id = a.phone_num_id
                LEFT JOIN profiles p
                    ON p.user_id = a.user_id
                LEFT JOIN contacts c
                    ON c.phone_num_id = a.phone_num_id
                LEFT JOIN phone_num_tokens pt
                    ON pt.phone_num_id = a.phone_num_id
            WHERE pt.token LIKE CONCAT(_query , '%')
            ORDER BY a.created_at DESC
            LIMIT _limit;
    END IF;

    -- return appointment notifications with limit
    IF _type = "name" THEN
        SELECT DISTINCT a.user_id, a.phone_num_id, pn.value, a.role, p.first_name, p.last_name, a.created_at, c.name     
            FROM authentication a
                LEFT JOIN phone_numbers pn
                    ON pn.phone_num_id = a.phone_num_id
                LEFT JOIN profiles p
                    ON p.user_id = a.user_id
                LEFT JOIN contacts c
                    ON c.phone_num_id = a.phone_num_id
                LEFT JOIN name_tokens nt
                    ON nt.phone_num_id = a.phone_num_id
            WHERE nt.token LIKE CONCAT(_query , '%')
            ORDER BY a.created_at DESC
            LIMIT _limit;
    END IF;

    -- return appointment notifications with limit
    SET token_  =  SUBSTRING_INDEX(_query, ' ', 1);

    IF _type = "name with spaces" THEN
        SELECT DISTINCT a.user_id, a.phone_num_id, pn.value, a.role, p.first_name, p.last_name, a.created_at, c.name     
            FROM authentication a
                LEFT JOIN phone_numbers pn
                    ON pn.phone_num_id = a.phone_num_id
                LEFT JOIN profiles p
                    ON p.user_id = a.user_id
                LEFT JOIN contacts c
                    ON c.phone_num_id = a.phone_num_id
                LEFT JOIN name_tokens nt
                    ON nt.phone_num_id = a.phone_num_id
            WHERE nt.token = token_
                AND
                    (c.name LIKE CONCAT('%', _query, '%')
                    OR  CONCAT(p.first_name, ' ', p.last_name) LIKE CONCAT('%', _query, '%'))
            ORDER BY a.created_at DESC
            LIMIT _limit;
    END IF;
END;