DROP PROCEDURE IF EXISTS sp_search_bookings;

CREATE PROCEDURE sp_search_bookings(
    IN _session JSON,
    IN _query VARCHAR(200),
    IN _limit INT
)
BEGIN    
    -- validate admin
    CALL sp_validate_admin(_session);

    -- return appointment notifications with limit
    SELECT an.appo_id, an.time, ad.employee_id, e.alias, c.code, ad.service_id, s.name, ca.name, ad.phone_num_id, pn.value, p.first_name, p.last_name, ad.date, ad.start_time, ad.end_time
        FROM appo_notifications an
            LEFT JOIN appo_details ad
                ON ad.appo_id = an.appo_id
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
            LEFT JOIN authentication a
                ON a.phone_num_id = ad.phone_num_id
            LEFT JOIN profiles p
                ON p.user_id = a.user_id
        WHERE pn.value LIKE CONCAT('+1', _query , '%')
            OR p.first_name LIKE CONCAT(_query , '%')
            OR p.last_name LIKE CONCAT(_query , '%')        
        ORDER BY time DESC
        LIMIT _limit;
END;
