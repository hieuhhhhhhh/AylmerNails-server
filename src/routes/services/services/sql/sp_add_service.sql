DROP PROCEDURE IF EXISTS sp_add_service;

CREATE PROCEDURE sp_add_service(
    IN _name VARCHAR(50),
    IN _category_id INT UNSIGNED,
    IN _AOSs JSON -- JSON array of all AOSs (add-on services) for this service
)
BEGIN
    -- index to iterate json array
    DECLARE i TINYINT DEFAULT 0;

    -- other place holders
    DECLARE service_id_ INT UNSIGNED;
    DECLARE AOS_id_ INT UNSIGNED;
    DECLARE prompt_ VARCHAR(400);
    DECLARE AOS_options_ JSON;

    -- create new service
    INSERT INTO services (name, category_id)
        VALUES (_name, _category_id);
    
    -- fetch id of new service
    SET service_id_ = LAST_INSERT_ID();

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

    -- return service_id
    SELECT service_id_;
END; 

