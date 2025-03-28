DROP PROCEDURE IF EXISTS sp_store_canceled_appo;

CREATE PROCEDURE sp_store_canceled_appo(
    IN _appo_id INT UNSIGNED,
    IN _user_id INT UNSIGNED
)
sp:BEGIN    
    -- variables
    DECLARE details_ JSON;

    -- fetch appo details 
    SELECT JSON_OBJECT(
        'appoId', ad.appo_id,
        'empId', ad.employee_id,
        'empAlias', e.alias,
        'serviceId', ad.service_id,
        'serviceName', s.name,
        'AOSOs', ad.selected_AOSO,
        'date', ad.date,
        'start', ad.start_time,
        'end', ad.end_time,
        'note', an.note,
        'color', c.code,
        'category', ca.name,
        'phoneNumId', ad.phone_num_id,
        'phoneNumber', p.value,
        'contactName', co.name
    ) 
    INTO details_
        FROM appo_details ad
            LEFT JOIN appo_notes an
                ON an.appo_id = ad.appo_id
            LEFT JOIN services s
                ON s.service_id = ad.service_id
            LEFT JOIN categories ca
                ON ca.category_id = s.category_id
            LEFT JOIN employees e
                ON e.employee_id = ad.employee_id
            LEFT JOIN colors c
                ON c.color_id = e.color_id
            LEFT JOIN phone_numbers p
                ON p.phone_num_id = ad.phone_num_id
            LEFT JOIN contacts co
                ON co.phone_num_id = ad.phone_num_id
        WHERE ad.appo_id = _appo_id;

    -- store details of canceled appointment
    IF details_ IS NOT NULL
    THEN
        INSERT INTO canceled_appos (user_id, details)
            VALUES (_user_id, details_);
    END IF;

END;

