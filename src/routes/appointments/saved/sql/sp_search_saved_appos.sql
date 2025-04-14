DROP PROCEDURE IF EXISTS sp_search_saved_appos;

CREATE PROCEDURE sp_search_saved_appos(
    IN _query VARCHAR(200),
    IN _limit INT
)
BEGIN    
    -- return saved appos with limit
    SELECT ad.employee_id, e.alias, c.code, ad.service_id, s.name, ca.name, ad.phone_num_id, pn.value, ct.name, ad.date, ad.start_time, ad.end_time
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
            LEFT JOIN contact_tokens to
                ON to.phone_num_id = ad.phone_num_id
        WHERE pn.value LIKE CONCAT('+1', _query , '%')
            OR to.token LIKE CONCAT(_query , '%')
        ORDER BY sa.time DESC
        LIMIT _limit;
END;