DROP PROCEDURE IF EXISTS sp_get_appo_details;

CREATE PROCEDURE sp_get_appo_details(
    IN _session JSON,
    IN _appo_id INT UNSIGNED
)
sp:BEGIN    
    -- variables
    DECLARE AOSOs_ JSON;
    DECLARE i INT DEFAULT 0;
    DECLARE AOS_id_ INT UNSIGNED;
    DECLARE option_id_ INT UNSIGNED;
    DECLARE question_ VARCHAR(400);
    DECLARE answer_ VARCHAR(300);
    DECLARE offset_ INT;

    -- validate session token
    CALL sp_validate_admin(_session);

    -- 1st table: appo info
    SELECT ad.appo_id, ad.employee_id, ad.service_id, ad.selected_AOSO, ad.date, ad.start_time, ad.end_time, ad.message, an.note, c.code, e.alias, s.name, ca.name, ad.phone_num_id, pn.value, at.user_id, co.name, sa.time, ad.booker_id, CONCAT(p.first_name, ' ', p.last_name)
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
            LEFT JOIN phone_numbers pn
                ON pn.phone_num_id = ad.phone_num_id
            LEFT JOIN contacts co
                ON co.phone_num_id = ad.phone_num_id
            LEFT JOIN authentication at
                ON at.phone_num_id = ad.phone_num_id
            LEFT JOIN profiles p
                ON p.user_id = ad.booker_id
            LEFT JOIN saved_appos sa
                ON sa.appo_id = ad.appo_id
            
        WHERE ad.appo_id = _appo_id;

    -- 2nd table: selected appo
    SELECT e.employee_id, e.alias
        FROM appo_employees ae
            JOIN employees e
                ON e.employee_id = ae.employee_id
        WHERE ae.appo_id = _appo_id;

    -- fetch AOSOs
    SELECT selected_AOSO
        INTO AOSOs_
        FROM appo_details 
        WHERE appo_id = _appo_id;

     -- iterate _selected_AOSO, fetch and merge offset of every AOSO 
    WHILE i < JSON_LENGTH(AOSOs_) DO 
        -- fetch every AOS_id_
        SET AOS_id_ = JSON_UNQUOTE(JSON_EXTRACT(AOSOs_, CONCAT('$[', i, ']')));
        SET i = i + 1;

        -- fetch the option id for that AOS
        SET option_id_ = JSON_UNQUOTE(JSON_EXTRACT(AOSOs_, CONCAT('$[', i, ']')));
        SET i = i + 1;

        -- fetch question
        SELECT prompt 
            INTO question_
            FROM add_on_services
            WHERE AOS_id = AOS_id_;

        -- fetch answer and offset
        SELECT name, length_offset 
            INTO answer_, offset_
            FROM AOS_options
            WHERE option_id = option_id_;

        -- next tables: questions and answers
        SELECT AOS_id_, question_, option_id_, answer_, offset_;

        -- end loop
    END WHILE; 
END;