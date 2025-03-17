DROP PROCEDURE IF EXISTS sp_get_appo_notifications;

CREATE PROCEDURE sp_get_appo_notifications(
    IN _session JSON,
    IN _limit INT
)
BEGIN    
    -- variables
    DECLARE user_id_ INT UNSIGNED;
    DECLARE role_ VARCHAR(20);
    
    -- validate session token
    CALL sp_validate_admin(_session);    

    -- return appointment notifications with limit
    SELECT an.appo_id, an.time, ad.employee_id, e.alias, c.code, ad.service_id, s.name, ca.name, ad.phone_num_id, pn.value, ad.date, ad.start_time, ad.end_time
        FROM appo_notifications an
            LEFT JOIN appo_details ad
                ON ad.appo_id = an.appo_id
            LEFT JOIN phone_numbers pn
                ON pn.phone_num_id = ad.phone_num_id
            LEFT JOIN services s
                ON s.service_id = ad.service_id
            LEFT JOIN categories ca
                ON c.category_id = s.category_id
            LEFT JOIN employees e
                ON e.employee_id = ad.employee_id
            LEFT JOIN colors c
                ON c.color_id = e.color_id
        ORDER BY an.time DESC
        LIMIT _limit;

    -- fetch user's id
    CALL sp_get_user_id_role(_session ,user_id_, role_)

    -- return user's last track 
    SELECT time
        FROM appos_tracker
        WHERE user_id = user_id_;

END;
