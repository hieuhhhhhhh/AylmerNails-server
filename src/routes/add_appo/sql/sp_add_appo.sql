
CREATE PROCEDURE s_add_appo(
    IN _employee_id INT UNSIGNED,
    IN _service_id INT UNSIGNED,
    IN _start_time BIGINT,
    IN _end_time BIGINT,
    IN _employees_selected VARCHAR(500) DEFAULT NULL,
    IN _created_by_client BOOLEAN DEFAULT TRUE
)
BEGIN
    INSERT INTO appo_details (
        employee_id, 
        service_id, 
        start_time, 
        end_time, 
        employees_selected, 
        created_by_client
    )
    VALUES (
        _employee_id, 
        _service_id, 
        _start_time, 
        _end_time, 
        _employees_selected, 
        _created_by_client
    );

    SELECT LAST_INSERT_ID();
END

