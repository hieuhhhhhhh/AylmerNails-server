DROP PROCEDURE IF EXISTS sp_search_saved_appos;

CREATE PROCEDURE sp_search_saved_appos(
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
        SELECT DISTINCT ad.appo_id, sa.time, ad.employee_id, e.alias, c.code, ad.service_id, s.name, ca.name, ad.phone_num_id, pn.value, ct.name, ad.date, ad.start_time, ad.end_time
            FROM saved_appos sa
                LEFT JOIN appo_details ad
                    ON ad.appo_id = sa.appo_id
                LEFT JOIN phone_numbers pn
                    ON pn.phone_num_id = ad.phone_num_id
                LEFT JOIN services s
                    ON s.service_id = ad.service_id
                LEFT JOIN categories ca
                    ON ca.category_id = s.category_id
                LEFT JOIN employees e
                    ON e.employee_id = ad.employee_id
                LEFT JOIN colors c
                    ON c.color_id = e.color_id
                LEFT JOIN contacts ct
                    ON ct.phone_num_id = ad.phone_num_id
                LEFT JOIN contact_tokens tk
                    ON tk.phone_num_id = ad.phone_num_id
            ORDER BY sa.time DESC
            LIMIT _limit;
    END IF;      

    -- return appointment notifications with limit
    IF _type = "phone number" THEN
        SELECT DISTINCT ad.appo_id, sa.time, ad.employee_id, e.alias, c.code, ad.service_id, s.name, ca.name, ad.phone_num_id, pn.value, ct.name, ad.date, ad.start_time, ad.end_time
            FROM saved_appos sa
                LEFT JOIN appo_details ad
                    ON ad.appo_id = sa.appo_id
                LEFT JOIN phone_numbers pn
                    ON pn.phone_num_id = ad.phone_num_id
                LEFT JOIN services s
                    ON s.service_id = ad.service_id
                LEFT JOIN categories ca
                    ON ca.category_id = s.category_id
                LEFT JOIN employees e
                    ON e.employee_id = ad.employee_id
                LEFT JOIN colors c
                    ON c.color_id = e.color_id
                LEFT JOIN contacts ct
                    ON ct.phone_num_id = ad.phone_num_id
                LEFT JOIN phone_num_tokens pt
                    ON pt.phone_num_id = ad.phone_num_id
            WHERE pt.token LIKE CONCAT(_query , '%')
            ORDER BY sa.time DESC
            LIMIT _limit;
    END IF;

    -- return appointment notifications with limit
    IF _type = "name" THEN
        SELECT DISTINCT ad.appo_id, sa.time, ad.employee_id, e.alias, c.code, ad.service_id, s.name, ca.name, ad.phone_num_id, pn.value, ct.name, ad.date, ad.start_time, ad.end_time
            FROM saved_appos sa
                LEFT JOIN appo_details ad
                    ON ad.appo_id = sa.appo_id
                LEFT JOIN phone_numbers pn
                    ON pn.phone_num_id = ad.phone_num_id
                LEFT JOIN services s
                    ON s.service_id = ad.service_id
                LEFT JOIN categories ca
                    ON ca.category_id = s.category_id
                LEFT JOIN employees e
                    ON e.employee_id = ad.employee_id
                LEFT JOIN colors c
                    ON c.color_id = e.color_id
                LEFT JOIN contacts ct
                    ON ct.phone_num_id = ad.phone_num_id
                LEFT JOIN name_tokens nt
                    ON nt.phone_num_id = ad.phone_num_id
            WHERE nt.token LIKE CONCAT(_query , '%')
            ORDER BY sa.time DESC
            LIMIT _limit;
    END IF;

      -- return appointment notifications with limit
    SET token_  =  SUBSTRING_INDEX(_query, ' ', 1);

    IF _type = "name with spaces" THEN
        SELECT DISTINCT ad.appo_id, sa.time, ad.employee_id, e.alias, c.code, ad.service_id, s.name, ca.name, ad.phone_num_id, pn.value, ct.name, ad.date, ad.start_time, ad.end_time
            FROM saved_appos sa
                LEFT JOIN appo_details ad
                    ON ad.appo_id = sa.appo_id
                LEFT JOIN phone_numbers pn
                    ON pn.phone_num_id = ad.phone_num_id
                LEFT JOIN services s
                    ON s.service_id = ad.service_id
                LEFT JOIN categories ca
                    ON ca.category_id = s.category_id
                LEFT JOIN employees e
                    ON e.employee_id = ad.employee_id
                LEFT JOIN colors c
                    ON c.color_id = e.color_id
                LEFT JOIN contacts ct
                    ON ct.phone_num_id = ad.phone_num_id
                LEFT JOIN name_tokens nt
                    ON nt.phone_num_id = ad.phone_num_id
                LEFT JOIN authentication a
                    ON a.phone_num_id = ad.phone_num_id
                LEFT JOIN profiles p
                    ON p.user_id = a.user_id
            WHERE nt.token = token_
                AND
                    (ct.name LIKE CONCAT('%', _query, '%')
                    OR  CONCAT(p.first_name, ' ', p.last_name) LIKE CONCAT('%', _query, '%'))
            ORDER BY sa.time DESC
            LIMIT _limit;
    END IF;
END;