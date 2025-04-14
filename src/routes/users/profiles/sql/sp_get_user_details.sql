DROP PROCEDURE IF EXISTS sp_get_user_details;

CREATE PROCEDURE sp_get_user_details(
    IN _user_id INT UNSIGNED
)
BEGIN    
    -- variables
    DECLARE yesterday_ BIGINT DEFAULT UNIX_TIMESTAMP() - 24*60*60;

    -- return user info
    SELECT a.role, a.created_at, pn.value, p.first_name, p.last_name, p.notes, c.name
        FROM authentication a
            LEFT JOIN phone_numbers pn
                ON pn.phone_num_id = a.phone_num_id
            LEFT JOIN profiles p
                ON p.user_id = a.user_id
            LEFT JOIN contacts c
                ON c.phone_num_id = a.phone_num_id
        WHERE a.user_id = _user_id;

    -- return user's appointments
    SELECT ad.appo_id, ad.employee_id, e.alias, c.code, ad.service_id, s.name, ca.name, ad.date, ad.start_time, ad.end_time
        FROM appo_details ad                                    
            LEFT JOIN services s
                ON s.service_id = ad.service_id
            LEFT JOIN categories ca
                ON ca.category_id = s.category_id
            LEFT JOIN employees e
                ON e.employee_id = ad.employee_id
            LEFT JOIN colors c
                ON c.color_id = e.color_id                                    
            LEFT JOIN authentication au
                ON au.phone_num_id = ad.phone_num_id
        WHERE au.user_id = _user_id
            AND ad.date > yesterday_
        ORDER BY ad.date, ad.start_time;        
END;