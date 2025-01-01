-- this proc find and store all apointments that conflict with service_lengths

DROP PROCEDURE IF EXISTS sp_scan_service_length_conflicts;

CREATE PROCEDURE sp_scan_service_length_conflicts(
    IN _service_id INT UNSIGNED,
    IN _scan_from BIGINT
)
BEGIN
        -- Exception handling to roll back in case of an error
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
        UNLOCK TABLES; -- release lock
        ROLLBACK; -- rollback transaction

    -- Start the transaction
    START TRANSACTION;

        -- Lock the service_length_conflicts table
        LOCK TABLES service_length_conflicts READ WRITE;


        -- Unlock the table when transaction is complete
        UNLOCK TABLES;

        -- Commit the transaction if everything went well
    COMMIT;
END;
