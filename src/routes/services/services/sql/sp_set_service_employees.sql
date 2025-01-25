DROP PROCEDURE IF EXISTS sp_set_service_employees;

CREATE PROCEDURE sp_set_service_employees(
    IN _service_id INT UNSIGNED,
    IN _employee_ids JSON
)
BEGIN
    -- index to iterate json array
    DECLARE i TINYINT DEFAULT 0;

    -- placeholder
    DECLARE employee_id_ INT UNSIGNED;

    WHILE i < JSON_LENGTH(_employee_ids) DO 
        -- fetch every service_id from the list
        SET employee_id_ = JSON_UNQUOTE(JSON_EXTRACT(_employee_ids, CONCAT('$[', i, ']')));
        SET i = i + 1;

        -- add new relationship on service_employees table
        INSERT INTO employee_services (employee_id, service_id)
            VALUES (employee_id_, _service_id);

        -- end loop
    END WHILE;
END;