DROP PROCEDURE IF EXISTS sp_add_appo_manually;

CREATE PROCEDURE sp_add_appo_manually(
    IN _emp_id INT UNSIGNED,
    IN _service_id INT UNSIGNED,
    IN _AOSOs JSON,
    IN _date BIGINT,
    IN _start INT,
    IN _end INT,
    IN _note VARCHAR(500)
)
sp:BEGIN
    -- create new appointment
    INSERT INTO appo_details (employee_id, service_id, selected_AOSO, date, start_time, end_time)
        VALUES (_emp_id, _service_id, _AOSOs, _date, _start, _end);

    -- return created appo_id
    SELECT LAST_INSERT_ID();
END;

