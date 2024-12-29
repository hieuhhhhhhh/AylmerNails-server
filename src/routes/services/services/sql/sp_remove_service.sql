DROP PROCEDURE IF EXISTS sp_remove_service;

CREATE PROCEDURE sp_remove_service(
    IN _service_id INT
)
BEGIN
    -- delete the row with the specified service_id
    DELETE FROM services
    WHERE service_id = _service_id;
    
    -- check if the deletion was successful (using ROW_COUNT)
    IF ROW_COUNT() = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Group ID not found.';
    END IF;
END; 

