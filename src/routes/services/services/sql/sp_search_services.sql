DROP PROCEDURE IF EXISTS sp_search_services;

CREATE PROCEDURE sp_search_services(
    IN _query VARCHAR(50),
)
BEGIN
    SELECT snt.service_id
        FROM service_name_tokens snt 
            JOIN services s 
                ON s.service_id = snt.service_id 
        WHERE snt.token LIKE CONCAT(_query, '%');
END;
