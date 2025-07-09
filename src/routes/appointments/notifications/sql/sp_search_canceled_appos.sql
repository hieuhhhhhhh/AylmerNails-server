DROP PROCEDURE IF EXISTS sp_search_canceled_appos;

CREATE PROCEDURE sp_search_canceled_appos(
    IN _session JSON,
    IN _query VARCHAR(200),
    IN _type VARCHAR(100),
    IN _limit INT
)
BEGIN    
    -- variables
    DECLARE token_ VARCHAR(200);

    -- validate admin
    CALL sp_validate_admin(_session);

      -- return appointment notifications with limit
    IF _type = "empty" THEN
        SELECT DISTINCT c.canceled_id, c.user_id, c.details, c.time, p.first_name, p.last_name, pn.value
            FROM canceled_appos c
                LEFT JOIN profiles p
                    ON p.user_id = c.user_id
                LEFT JOIN authentication a
                    ON a.user_id = c.user_id
                LEFT JOIN phone_numbers pn
                    ON pn.phone_num_id = a.phone_num_id
            ORDER BY c.time DESC
            LIMIT _limit;
    END IF;      

    -- return appointment notifications with limit
    IF _type = "phone number" THEN
        SELECT DISTINCT c.canceled_id, c.user_id, c.details, c.time, p.first_name, p.last_name, pn.value
            FROM canceled_appos c
                LEFT JOIN profiles p
                    ON p.user_id = c.user_id
                LEFT JOIN authentication a
                    ON a.user_id = c.user_id
                LEFT JOIN phone_numbers pn
                    ON pn.phone_num_id = a.phone_num_id
                LEFT JOIN phone_num_tokens pt
                    ON pt.phone_num_id = a.phone_num_id
            WHERE pt.token LIKE CONCAT(_query , '%')
            ORDER BY c.time DESC
            LIMIT _limit;
    END IF;

    -- return appointment notifications with limit
    IF _type = "name" THEN
        SELECT DISTINCT c.canceled_id, c.user_id, c.details, c.time, p.first_name, p.last_name, pn.value
            FROM canceled_appos c
                LEFT JOIN profiles p
                    ON p.user_id = c.user_id
                LEFT JOIN authentication a
                    ON a.user_id = c.user_id
                LEFT JOIN phone_numbers pn
                    ON pn.phone_num_id = a.phone_num_id
                LEFT JOIN name_tokens nt
                    ON nt.phone_num_id = a.phone_num_id
            WHERE nt.token LIKE CONCAT(_query , '%')
            ORDER BY c.time DESC
            LIMIT _limit;
    END IF;

    -- return appointment notifications with limit
    SET token_  =  SUBSTRING_INDEX(_query, ' ', 1);

    IF _type = "name with spaces" THEN
        SELECT DISTINCT c.canceled_id, c.user_id, c.details, c.time, p.first_name, p.last_name, pn.value
            FROM canceled_appos c
                LEFT JOIN profiles p
                    ON p.user_id = c.user_id
                LEFT JOIN authentication a
                    ON a.user_id = c.user_id
                LEFT JOIN phone_numbers pn
                    ON pn.phone_num_id = a.phone_num_id
                LEFT JOIN contacts ct
                    ON c.phone_num_id = a.phone_num_id
                LEFT JOIN name_tokens nt
                    ON nt.phone_num_id = a.phone_num_id
            WHERE nt.token = token_
                AND
                    (ct.name LIKE CONCAT('%', _query, '%')
                    OR  CONCAT(p.first_name, ' ', p.last_name) LIKE CONCAT('%', _query, '%'))
            ORDER BY an.time DESC
            LIMIT _limit;
    END IF;
END;
