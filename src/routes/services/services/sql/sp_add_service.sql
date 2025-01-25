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
    -- iterator
    DECLARE i TINYINT DEFAULT 0;
    -- variables
    DECLARE service_id_ INT UNSIGNED;
    DECLARE AOS_id_ INT UNSIGNED;
    DECLARE prompt_ VARCHAR(400);
    DECLARE AOS_options_ JSON;

    -- validate session token
    CALL sp_validate_admin(_session);

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
    CALL sp_store_name_tokens(service_id_, _service_name_tokens);

    -- set service list for the new employee
    CALL sp_set_service_employees(service_id_, _employee_ids);

    -- return service_id
    SELECT service_id_;
END;