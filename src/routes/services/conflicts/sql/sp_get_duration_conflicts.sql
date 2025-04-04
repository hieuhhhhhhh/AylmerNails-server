DROP PROCEDURE IF EXISTS sp_get_duration_conflicts;

CREATE PROCEDURE sp_get_duration_conflicts(
    IN _service_id INT UNSIGNED
)
BEGIN    
    SELECT dc.*,  ad.date, ad.day_of_week, ad.start_time, ad.end_time, e.alias, s.name, c.name, c.phone_num_id, pn.value, cl.code
        FROM duration_conflicts dc
            JOIN appo_details ad
                ON ad.appo_id = dc.appo_id
            JOIN contacts c
                ON c.phone_num_id = ad.phone_num_id
            JOIN phone_numbers pn
                ON pn.phone_num_id = ad.phone_num_id
            JOIN employees e
                ON e.employee_id = ad.employee_id
            JOIN colors cl
                ON cl.color_id = e.color_id
            JOIN services s
                ON s.service_id = ad.service_id
        WHERE dc.service_id = _service_id;
END;