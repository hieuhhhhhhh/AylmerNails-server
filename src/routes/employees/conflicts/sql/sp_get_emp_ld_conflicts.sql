DROP PROCEDURE IF EXISTS sp_get_emp_ld_conflicts;

CREATE PROCEDURE sp_get_emp_ld_conflicts(
    IN _emp_id INT UNSIGNED
)
BEGIN    
    SELECT ec.*, ad.date, ad.day_of_week, ad.start_time, ad.end_time, e.alias, s.name
        FROM ELD_conflicts ec
            JOIN appo_details ad
                ON ad.appo_id = ec.appo_id
            JOIN employees e
                ON e.employee_id = ad.employee_id
            JOIN services s
                ON e.service_id = ad.service_id
        WHERE ec.employee_id = _emp_id;
END;