DROP PROCEDURE IF EXISTS sp_add_service;

CREATE PROCEDURE sp_add_service(
    IN _session JSON,
    IN _name VARCHAR(50),
    IN _service_name_tokens JSON, -- array of tokens of service's name
    IN _category_id INT UNSIGNED,
    IN _description VARCHAR(500),
    IN _date BIGINT,
    IN _length INT,
    IN _AOSs JSON, -- JSON array of all AOSs (add-on services) for this service
    IN _employee_ids JSON
)
sp:BEGIN
    -- index to iterate json array
    DECLARE i TINYINT DEFAULT 0;

    -- other place holders
    DECLARE user_id_ INT UNSIGNED;
    DECLARE role_ VARCHAR(20);
    DECLARE service_id_ INT UNSIGNED;
    DECLARE AOS_id_ INT UNSIGNED;
    DECLARE prompt_ VARCHAR(400);
    DECLARE AOS_options_ JSON;

    -- fetch and validate user's role from session data
    CALL sp_get_user_id_role(_session, user_id_, role_);

    -- IF role is not valid return null and leave procedure
    IF role_ IS NULL
        OR role_ NOT IN ('admin', 'developer')
    THEN 
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '401, Unauthorized';
    END IF;

    -- create new service
    INSERT INTO services (name, description, category_id)
        VALUES (_name, _description, _category_id);
    
    -- fetch id of new service
    SET service_id_ = LAST_INSERT_ID();

    -- create first service length
    INSERT INTO service_lengths (service_id, effective_from, length)
        VALUES (service_id_, _date, _length);

    -- start iterating to fetch all AOSs from the JSON array
    WHILE i < JSON_LENGTH(_AOSs) DO 
        -- fetch prompt of AOS
        SET prompt_ = JSON_UNQUOTE(JSON_EXTRACT(_AOSs, CONCAT('$[', i, ']')));
        SET i = i + 1;

        -- fetch the the json array that contain all options for this AOS
        SET AOS_options_ = JSON_UNQUOTE(JSON_EXTRACT(_AOSs, CONCAT('$[', i, ']')));
        SET i = i + 1;

        -- call the sp that hanlde adding AOS options
        CALL sp_add_AOS(service_id_, prompt_, AOS_options_);

        -- end loop
    END WHILE;

    -- extract and store name tokens
    CALL sp_store_name_tokens(_service_id, _service_name_tokens);

    -- set service list for the new employee
    CALL sp_set_service_employees(_service_id, _employee_ids);

    -- return service_id
    SELECT service_id_;
END;