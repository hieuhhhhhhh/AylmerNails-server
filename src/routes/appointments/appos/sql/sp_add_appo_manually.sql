DROP PROCEDURE IF EXISTS sp_add_appo_manually;

CREATE PROCEDURE sp_add_appo_manually(
    IN _employee_id INT UNSIGNED,
    IN _service_id INT UNSIGNED,
    IN _selected_AOSO JSON,
    IN _date BIGINT,
    IN _start_time INT,
    IN _end_time INT,
    IN _employees_selected VARCHAR(500)
)
sp:BEGIN
END;

