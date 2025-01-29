DROP PROCEDURE IF EXISTS sp_update_SEs;

CREATE PROCEDURE sp_update_SEs(
    IN _session JSON,
    IN _service_id INT UNSIGNED,
    IN _employee_ids JSON
)
BEGIN
    -- iterator
    DECLARE i INT DEFAULT 0;
    -- variables
    DECLARE employee_id_ INT UNSIGNED;

    -- validate session token
    CALL sp_validate_admin(_session);

    -- clean old data
    DELETE FROM employee_services
        WHERE service_id = _service_id;

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