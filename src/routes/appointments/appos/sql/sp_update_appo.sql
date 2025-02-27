DROP PROCEDURE IF EXISTS sp_update_appo;

CREATE PROCEDURE sp_update_appo(
    IN _appo_id INT UNSIGNED,
    IN _emp_id INT UNSIGNED,
    IN _service_id INT UNSIGNED,
    IN _AOSOs JSON,
    IN _date BIGINT,
    IN _start INT,
    IN _end INT,
    IN _note VARCHAR(500)
)
sp:BEGIN
    -- remove last appointment
    DELETE FROM appo_details
        WHERE appo_id = _appo_id;

    -- create new appointment
    CALL sp_add_appo_manually(_emp_id, _service_id, _AOSOs, _date, _start, _end, _note);
END;

