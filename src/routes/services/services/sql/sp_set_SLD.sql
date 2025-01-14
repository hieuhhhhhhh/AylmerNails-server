-- SLD = service's last date

DROP PROCEDURE IF EXISTS sp_set_SLD;

CREATE PROCEDURE sp_set_SLD(
    IN  _service_id INT UNSIGNED, 
    IN  _last_date BIGINT
)
BEGIN
    -- Check if the employee exists
    IF NOT EXISTS (SELECT 1 FROM services WHERE service_id = _service_id) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid service_id, no such employee exists';
    END IF;

    -- Update the last_date for the given service_id
    UPDATE services
        SET last_date = _last_date
        WHERE service_id = _service_id;

    -- Call sp_scan_SLD_conflicts to find any appointments that conflict the update
    CALL sp_scan_SLD_conflicts(_service_id);
END;
