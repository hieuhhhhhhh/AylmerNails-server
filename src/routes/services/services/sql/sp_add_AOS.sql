-- AOS = add on service

DROP PROCEDURE IF EXISTS sp_add_AOS;

CREATE PROCEDURE sp_add_AOS(
    IN _service_id INT UNSIGNED,
    IN _prompt VARCHAR(400), 
    IN _AOS_options JSON -- a json array of AOS options
)
BEGIN
    -- index to iterate json array
    DECLARE i TINYINT DEFAULT 0;

    -- other place holders
    DECLARE AOS_id_ INT UNSIGNED;
    DECLARE name_ VARCHAR(300);
    DECLARE length_offset_ INT;

    -- create new AOS
    INSERT INTO add_on_services (service_id, prompt)
        VALUES (_service_id, _prompt);
    
    -- fetch id of new AOS
    SET AOS_id_ =  LAST_INSERT_ID();

    -- start iterating to fetch options from the JSON array
    WHILE i < JSON_LENGTH(_AOS_options) DO 
        -- fetch name of an option
        SET name_ = JSON_UNQUOTE(JSON_EXTRACT(_AOS_options, CONCAT('$[', i, ']')));
        SET i = i + 1;

        -- fetch offset of an option
        SET length_offset_ = JSON_UNQUOTE(JSON_EXTRACT(_AOS_options, CONCAT('$[', i, ']')));
        SET i = i + 1;

        -- Insert the new AOS options into the AOS_options table
        INSERT INTO AOS_options (AOS_id, name, length_offset)
            VALUES (AOS_id_, name_, length_offset_);
        
        -- end loop
    END WHILE;
END; 

