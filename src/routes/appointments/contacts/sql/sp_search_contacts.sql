DROP PROCEDURE IF EXISTS sp_search_contacts;

CREATE PROCEDURE sp_search_contacts(
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
    SELECT DISTINCT p.value, c.phone_num_id, c.name, c.time, pr.first_name, pr.last_name
        FROM phone_numbers p
            JOIN contacts c
                ON c.phone_num_id = p.phone_num_id
            LEFT JOIN authentication au
                ON au.phone_num_id = p.phone_num_id
            LEFT JOIN profiles pr
                ON pr.user_id = au.user_id
            ORDER BY c.time DESC
            LIMIT _limit;
    END IF;

    -- return appointment notifications with limit
    IF _type = "phone number" THEN
        SELECT DISTINCT p.value, c.phone_num_id, c.name, c.time, pr.first_name, pr.last_name
            FROM phone_numbers p
                JOIN contacts c
                    ON c.phone_num_id = p.phone_num_id
                LEFT JOIN authentication au
                    ON au.phone_num_id = p.phone_num_id
                LEFT JOIN profiles pr
                    ON pr.user_id = au.user_id
                LEFT JOIN phone_num_tokens pt
                    ON pt.phone_num_id = p.phone_num_id
            WHERE pt.token LIKE CONCAT(_query , '%')
            ORDER BY c.time DESC
            LIMIT _limit;
    END IF;


    -- return appointment notifications with limit
    IF _type = "name" THEN
        SELECT DISTINCT p.value, c.phone_num_id, c.name, c.time, pr.first_name, pr.last_name
            FROM phone_numbers p
                JOIN contacts c
                    ON c.phone_num_id = p.phone_num_id

                LEFT JOIN authentication au
                    ON au.phone_num_id = p.phone_num_id
                LEFT JOIN profiles pr
                    ON pr.user_id = au.user_id
                LEFT JOIN name_tokens nt
                    ON nt.phone_num_id = p.phone_num_id
            WHERE nt.token LIKE CONCAT(_query , '%')
            ORDER BY c.time DESC
            LIMIT _limit;
    END IF;

    
    -- return appointment notifications with limit
    SET token_  =  SUBSTRING_INDEX(_query, ' ', 1);

    IF _type = "name with spaces" THEN
        SELECT DISTINCT p.value, c.phone_num_id, c.name, c.time, pr.first_name, pr.last_name
            FROM phone_numbers p
                JOIN contacts c
                    ON c.phone_num_id = p.phone_num_id

                LEFT JOIN authentication au
                    ON au.phone_num_id = p.phone_num_id
                LEFT JOIN profiles pr
                    ON pr.user_id = au.user_id
                LEFT JOIN name_tokens nt
                    ON nt.phone_num_id = p.phone_num_id
            WHERE nt.token = token_
                AND
                    (c.name LIKE CONCAT('%', _query, '%')
                    OR  CONCAT(pr.first_name, ' ', pr.last_name) LIKE CONCAT('%', _query, '%'))
            ORDER BY c.time DESC
            LIMIT _limit;
    END IF;
END;
