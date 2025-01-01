-- ELD = service's last date
-- this proc find and store all apointments that conflict with the new last_date of an service

DROP PROCEDURE IF EXISTS sp_scan_SLD_conflicts;

CREATE PROCEDURE sp_scan_SLD_conflicts(
    IN _service_id INT UNSIGNED
)
BEGIN
    DECLARE last_date_ BIGINT;

    -- Exception handling to roll back in case of an error
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
        UNLOCK TABLES; -- release lock
        ROLLBACK; -- rollback transaction

    -- Start the transaction
    START TRANSACTION;

        -- Lock the SLD_conflicts table
        LOCK TABLES SLD_conflicts READ WRITE;

        -- Fetch last_date of the given service
        SELECT last_date
            INTO last_date_
            FROM services
            WHERE service_id = _service_id
            LIMIT 1;

        -- Proceed only if last_date is not NULL
        IF last_date_ IS NOT NULL THEN
            
            -- Remove all existing conflicts for the given service before revalidating
            DELETE FROM SLD_conflicts
                WHERE service_id = _service_id;

            -- Insert appointments with a date greater than the service's last_date into SLD_conflicts
            INSERT INTO SLD_conflicts (appo_id, service_id)
                SELECT appo_id, _service_id
                    FROM appo_details
                    WHERE service_id = _service_id
                        AND date >= UNIX_TIMESTAMP()
                        AND date > last_date_;
        END IF;

        -- Unlock the table after transaction is complete
        UNLOCK TABLES;

        -- Commit the transaction if everything went well
    COMMIT;
END;
