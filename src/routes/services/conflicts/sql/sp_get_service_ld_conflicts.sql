DROP PROCEDURE IF EXISTS sp_get_service_ld_conflicts;

CREATE PROCEDURE sp_get_service_ld_conflicts(
    IN _service_id INT UNSIGNED
)
BEGIN    
    SELECT sc.*, ad.date, ad.day_of_week, ad.start_time, ad.end_time, e.alias, s.name
        FROM SLD_conflicts sc
            JOIN appo_details ad
                ON ad.appo_id = sc.appo_id
            JOIN employees e
                ON e.employee_id = ad.employee_id
            JOIN services s
                ON s.service_id = ad.service_id
        WHERE sc.service_id = _service_id;
END;