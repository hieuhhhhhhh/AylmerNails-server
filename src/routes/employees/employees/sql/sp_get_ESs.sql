DROP PROCEDURE IF EXISTS sp_get_ESs;

CREATE PROCEDURE sp_get_ESs(
    IN _employee_id INT UNSIGNED,
    IN _date BIGINT
)
BEGIN
    SELECT 
        s.service_id,
        s.name, 
        s.category_id,
        es.employee_id
            FROM services s
                LEFT JOIN employee_services es 
                    ON s.service_id = es.service_id
                        AND es.employee_id = _employee_id
            WHERE last_date IS NULL 
                OR last_date >= _date;

    SELECT category_id, name 
        FROM categories;
END;

