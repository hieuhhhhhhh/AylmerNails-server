DROP PROCEDURE IF EXISTS sp_set_ESs;

CREATE PROCEDURE sp_set_ESs(
    IN _employee_id INT UNSIGNED,
    IN _service_ids JSON
)
BEGIN
    -- index to iterate json array
    DECLARE i INT DEFAULT 0;

    -- placeholder
    DECLARE service_id_ INT UNSIGNED;

    WHILE i < JSON_LENGTH(_service_ids) DO 
        -- fetch every service_id from the list
        SET service_id_ = JSON_UNQUOTE(JSON_EXTRACT(_service_ids, CONCAT('$[', i, ']')));
        SET i = i + 1;

        -- add new relationship on service_employees table
        INSERT INTO employee_services (employee_id, service_id)
            VALUES (_employee_id, service_id_);

        -- end loop
    END WHILE;
END;