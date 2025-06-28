DROP PROCEDURE IF EXISTS sp_get_AOSs;

CREATE PROCEDURE sp_get_AOSs(
    IN _service_id INT UNSIGNED
)
BEGIN
    -- return service details
    SELECT name, description, duration, price, client_can_book
        FROM services
        WHERE service_id = _service_id;

    -- return service's questions
    SELECT ao.option_id, ao.name, ao.length_offset, aos.AOS_id, aos.prompt
        FROM services s                  
            JOIN add_on_services aos 
                ON aos.service_id = s.service_id
            JOIN AOS_options ao 
                ON ao.AOS_id = aos.AOS_id 
        WHERE s.service_id = _service_id;
END;
