DROP PROCEDURE IF EXISTS sp_add_appo_by_DELA;

CREATE PROCEDURE sp_add_appo_by_DELA(
    IN _employee_id INT UNSIGNED,
    IN _service_id INT UNSIGNED,
    IN _selected_AOSO JSON,
    IN _date BIGINT,
    IN _start_time INT,
    IN _end_time INT,
    IN _employees_selected VARCHAR(500),
)
sp:BEGIN
    -- placeholders
    DECLARE service_length_id_ INT UNSIGNED;
    DECLARE length_ INT;
    DECLARE DELA_id_ INT UNSIGNED;

    -- Exception handling to roll back in case of an error
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
        UNLOCK TABLES; -- release lock
        ROLLBACK; -- rollback transaction

    -- Start the transaction
    START TRANSACTION;
        -- Lock the appo_details table for writing to prevent other transactions from modifying it
        LOCK TABLES appo_details, DEL_availability, DEL_available_times READ WRITE;

        -- fetch length_ from the given description
        CALL sp_get_service_length(
            _service_id, 
            _employee_id, 
            _date, 
            _selected_AOSO, 
            service_length_id_, 
            length_
        );

        -- fetch the DELA_id that matches the length, date, employee
        SELECT DELA_id
            INTO DELA_id_
            FROM DEL_availability
            WHERE date = _date
                AND employee_id = _employee_id
                AND service_length = length_

        -- check if the start time is valid to a DEL_availability
        IF EXISTS(
            SELECT 1 
                FROM DEL_available_times
                WHERE 
                    DELA_id = DELA_id_
                    start_time = _start_time
        ) 
        THEN 
            -- if the start time exists in DELA, add the new appointment
            INSERT INTO appo_details (
                employee_id, 
                service_id, 
                selected_AOSO,
                start_time, 
                end_time
            )
            VALUES (
                _employee_id, 
                _service_id, 
                _selected_AOSO,
                _start_time, 
                _end_time
            );

            -- remove the used DELA (after a write that DELA will be invalid)
            DELETE FROM DEL_availability
                WHERE DELA_id = DELA_id_;
                
            -- Return the ID of the newly inserted appointment
            SELECT LAST_INSERT_ID() AS new_appo_id;
        ELSE
            -- if description not matches DELA, return null
            SELECT NULL;
        END IF;

        -- Unlock the appo_details table
        UNLOCK TABLES;

        -- Commit the transaction if everything went well
    COMMIT;
END;

