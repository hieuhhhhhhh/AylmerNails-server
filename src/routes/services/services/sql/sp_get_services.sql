DROP PROCEDURE IF EXISTS sp_get_services;

CREATE PROCEDURE sp_get_services(
    IN _date BIGINT
)
BEGIN
    SELECT 
        service_id,
        name, 
        last_date,
        (
            (last_date IS NULL OR last_date >= _date)
            AND _date >= first_date
        ),
        category_id
            FROM services ;

    SELECT category_id, name 
        FROM categories;
END;
