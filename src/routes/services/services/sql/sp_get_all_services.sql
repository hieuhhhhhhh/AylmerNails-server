DROP PROCEDURE IF EXISTS sp_get_all_services;

CREATE PROCEDURE sp_get_all_services()
BEGIN
    SELECT s.service_id, s.name, s.category_id, c.name, c.group_id, cg.name
        FROM services s 
            LEFT JOIN categories c
                ON s.category_id = c.category_id
            LEFT JOIN category_groups cg
                ON c.group_id = cg.group_id;
END;
