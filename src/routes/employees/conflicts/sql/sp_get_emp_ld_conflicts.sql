DROP PROCEDURE IF EXISTS sp_get_emp_ld_conflicts;

CREATE PROCEDURE sp_get_emp_ld_conflicts(
    IN _emp_id INT UNSIGNED
)
BEGIN    
    SELECT ec.*, ad.date, ad.day_of_week, ad.start_time, ad.end_time, e.alias, s.name, c.name, c.phone_num_id, pn.value, ca.name
        FROM ELD_conflicts ec
            LEFT JOIN appo_details ad
                ON ad.appo_id = ec.appo_id
            LEFT JOIN contacts c
                ON c.phone_num_id = ad.phone_num_id
            LEFT JOIN phone_numbers pn
                ON pn.phone_num_id = ad.phone_num_id
            LEFT JOIN employees e
                ON e.employee_id = ad.employee_id            
            LEFT JOIN services s
                ON s.service_id = ad.service_id
            LEFT JOIN categories ca
                ON ca.category_id = s.category_id
        WHERE ec.employee_id = _emp_id;
END;