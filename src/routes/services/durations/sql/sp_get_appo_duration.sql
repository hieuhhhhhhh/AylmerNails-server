DROP PROCEDURE IF EXISTS sp_get_appo_duration;

CREATE PROCEDURE sp_get_appo_duration(
    IN _service_id INT UNSIGNED,
    IN _emp_id INT UNSIGNED,
    IN _AOSOs JSON
)
BEGIN    
    SELECT fn_calculate_duration (_service_id, _emp_id, _AOSOs);
END;