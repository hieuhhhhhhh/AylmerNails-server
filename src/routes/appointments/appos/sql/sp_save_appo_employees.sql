DROP PROCEDURE IF EXISTS sp_save_appo_employees;

CREATE PROCEDURE sp_save_appo_employees(
    IN _appo_id INT UNSIGNED,
    IN _selected_emps JSON
)
sp:BEGIN
    -- variables
    DECLARE i INT DEFAULT 0;
    DECLARE emp_id_ INT UNSIGNED;

    -- read JSON
    WHILE i < JSON_LENGTH(_selected_emps) DO
        -- fetch every employee id
        SET emp_id_ = JSON_UNQUOTE(JSON_EXTRACT(_selected_emps, CONCAT('$[', i, ']')));
        SET i = i + 1;

        -- append row in junction table
        INSERT IGNORE appo_employees (appo_id, employee_id)
            VALUES (_appo_id, emp_id_);

        -- end loop
    END WHILE;

END;