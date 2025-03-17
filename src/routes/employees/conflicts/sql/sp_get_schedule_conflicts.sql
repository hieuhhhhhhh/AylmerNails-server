DROP PROCEDURE IF EXISTS sp_get_schedule_conflicts;

CREATE PROCEDURE sp_get_schedule_conflicts(
    IN _emp_id INT UNSIGNED
)
BEGIN    
    -- return appointments' information with their conflicting schedule_id
    SELECT sc.*, ad.date, ad.day_of_week, ad.start_time, ad.end_time, e.alias, s.name
        FROM schedule_conflicts sc
            JOIN appo_details ad
                ON ad.appo_id = sc.appo_id
            JOIN schedules s
                ON s.schedule_id = sc.schedule_id
            JOIN employees e
                ON e.employee_id = ad.employee_id
            JOIN services s
                ON e.service_id = ad.service_id
        WHERE s.employee_id = _emp_id;

    -- return employee schedules' details
    CALL sp_get_employee_schedules(_emp_id);
END;