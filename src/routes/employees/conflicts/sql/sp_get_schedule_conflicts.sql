DROP PROCEDURE IF EXISTS sp_get_schedule_conflicts;

CREATE PROCEDURE sp_get_schedule_conflicts(
    IN _emp_id INT UNSIGNED
)
BEGIN    
    -- return appointments' information with their conflicting schedule_id
    SELECT sc.*, ad.date, ad.day_of_week, ad.start_time, ad.end_time, e.alias, s.name, ca.name, c.name, c.phone_num_id, pn.value, oh.opening_time, oh.closing_time
        FROM schedule_conflicts sc
            LEFT JOIN appo_details ad
                ON ad.appo_id = sc.appo_id
            LEFT JOIN contacts c
                ON c.phone_num_id = ad.phone_num_id
            LEFT JOIN phone_numbers pn
                ON pn.phone_num_id = ad.phone_num_id
            LEFT JOIN schedules sh
                ON sh.schedule_id = sc.schedule_id
            LEFT JOIN opening_hours oh
                ON oh.schedule_id = sc.schedule_id 
                    AND oh.day_of_week = ad.day_of_week
            LEFT JOIN employees e
                ON e.employee_id = ad.employee_id
            LEFT JOIN services s
                ON s.service_id = ad.service_id
            LEFT JOIN categories ca
                ON ca.category_id = s.category_id
        WHERE e.employee_id = _emp_id;

    -- return employee schedules' details
    CALL sp_get_employee_schedules(_emp_id);
END;