-- this proc find and store all apointments that conflict with service_lengths

DROP PROCEDURE IF EXISTS sp_scan_service_length_conflicts;

CREATE PROCEDURE sp_scan_service_length_conflicts(
    IN _service_id INT UNSIGNED,
    IN _scan_from BIGINT
)
BEGIN
    
END;
