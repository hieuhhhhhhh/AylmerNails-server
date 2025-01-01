-- ELD = service's last date
-- this proc find and store all apointments that conflict with the new last_date of an service

DROP PROCEDURE IF EXISTS sp_find_SLD_conflicts;

CREATE PROCEDURE sp_find_SLD_conflicts(
    IN _service_id INT UNSIGNED
)
BEGIN
    DECLARE last_date_ BIGINT;
    DECLARE exit HANDLER FOR SQLEXCEPTION
        UNLOCK TABLES;
        ROLLBACK;  -- Rollback if there is any error

    -- Start the transaction
    START TRANSACTION;

        -- Fetch last_date of the given service
        SELECT last_date
            INTO last_date_
            FROM services
            WHERE service_id = _service_id
            LIMIT 1;

        -- Proceed only if last_date is not NULL
        IF last_date_ IS NOT NULL THEN
            -- Lock the SLD_conflicts table
            LOCK TABLES SLD_conflicts READ WRITE;
            
            -- Remove all existing conflicts for the given service before revalidating
            DELETE FROM SLD_conflicts
                WHERE service_id = _service_id;

            -- Insert appointments with a date greater than the service's last_date into SLD_conflicts
            INSERT INTO SLD_conflicts (appo_id, service_id)
                SELECT appo_id, _service_id
                    FROM appo_details
                    WHERE date > last_date_ 
                        AND service_id = _service_id;

            -- Unlock the table after operations are complete
            UNLOCK TABLES;
        END IF;

        -- Commit the transaction if everything went well
    COMMIT;
END;
