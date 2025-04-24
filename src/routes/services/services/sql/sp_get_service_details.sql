DROP PROCEDURE IF EXISTS sp_get_service_details;

CREATE PROCEDURE sp_get_service_details(
    IN _session JSON,
    IN _service_id INT UNSIGNED
)
BEGIN
    -- variables
    DECLARE duration_id_ INT UNSIGNED;
    
    -- validate admin
    CALL sp_validate_admin(_session);

    -- return table: service details
    SELECT s.service_id, s.name, s.description, s.first_date, s.last_date, s.duration, s.category_id, c.name
        FROM services s 
            LEFT JOIN categories c
                ON s.category_id = c.category_id
        WHERE s.service_id = _service_id;

    -- return duration
    SELECT e.employee_id, e.alias, d.duration
        FROM durations d
            JOIN employees e
        WHERE d.service_id = service_id;

    -- return table: service AOSs
    SELECT o.option_id, o.name, o.length_offset, a.AOS_id, a.prompt
        FROM AOS_options o
            RIGHT JOIN add_on_services a
                ON o.AOS_id = a.AOS_id
        WHERE a.service_id = _service_id
        ORDER BY o.AOS_id;
    
    -- return last date conflicts count
    SELECT COUNT(*)
        FROM sld_conflicts    
        WHERE service_id = _service_id;

    -- return duration conflicts count
    SELECT COUNT(*)
        FROM duration_conflicts    
        WHERE service_id = _service_id;
        
END;
