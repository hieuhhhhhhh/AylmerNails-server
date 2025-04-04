DROP PROCEDURE IF EXISTS sp_get_service_ld_conflicts;

CREATE PROCEDURE sp_get_service_ld_conflicts(
    IN _service_id INT UNSIGNED
)
BEGIN    
    SELECT sc.*, ad.date, ad.day_of_week, ad.start_time, ad.end_time, e.alias, s.name, c.name, c.phone_num_id, pn.value, cl.code
        FROM SLD_conflicts sc
            LEFT JOIN appo_details ad
                ON ad.appo_id = sc.appo_id
            LEFT JOIN contacts c
                ON c.phone_num_id = ad.phone_num_id
            LEFT JOIN phone_numbers pn
                ON pn.phone_num_id = ad.phone_num_id
            LEFT JOIN employees e
                ON e.employee_id = ad.employee_id
            LEFT JOIN colors cl
                ON cl.color_id = e.color_id
            LEFT JOIN services s
                ON s.service_id = ad.service_id
        WHERE sc.service_id = _service_id;
END;