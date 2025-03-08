DROP PROCEDURE IF EXISTS sp_get_duration_conflicts;

CREATE PROCEDURE sp_get_duration_conflicts(
    IN _service_id INT UNSIGNED
)
BEGIN    
    SELECT dc.*, ad.date, ad.day_of_week, ad.start_time, ad.end_time, e.alias, s.name
        FROM duration_conflicts dc
            JOIN appo_details ad
                ON ad.appo_id = dc.appo_id
            JOIN employees e
                ON e.employee_id = ad.employee_id
            JOIN services s
                ON e.service_id = ad.service_id
        WHERE dc.service_id = _service_id;
END;