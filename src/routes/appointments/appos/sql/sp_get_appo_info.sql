DROP PROCEDURE IF EXISTS sp_get_appo_info;

CREATE PROCEDURE sp_get_appo_info(
    IN _appo_id INT UNSIGNED
)
sp:BEGIN    
    SELECT ad.date, ad.start_time, ad.end_time, s.name
        FROM appo_details ad
            JOIN services s
                ON s.service_id = ad.service_id
        WHERE ad.appo_id = _appo_id;
END;