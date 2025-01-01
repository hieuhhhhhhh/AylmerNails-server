DROP PROCEDURE IF EXISTS sp_scan_schedule_conflicts;

CREATE PROCEDURE sp_scan_schedule_conflicts(
    IN _employee_id INT UNSIGNED,
    IN _scan_from BIGINT
)
BEGIN
    DECLARE done TINYINT DEFAULT 0;
    DECLARE schedule_id_ INT UNSIGNED;
    DECLARE appo_id_ INT UNSIGNED;
    DECLARE date_ BIGINT;
    DECLARE start_time_ INT;
    DECLARE end_time_ INT;

    -- Exception handling to roll back in case of an error
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
        UNLOCK TABLES; -- release lock
        ROLLBACK; -- rollback transaction

    -- Start the transaction
    START TRANSACTION;    
        -- Lock the schedule_conflicts table
        LOCK TABLES schedule_conflicts READ WRITE;

        -- clean old conflicts from last schedules
        CALL sp_clean_old_schedule_conflicts(_employee_id, _scan_from);

        -- Declare the cursor for fetching the appointment details
        DECLARE cur CURSOR FOR
            SELECT date, start_time, end_time, appo_id
                FROM appo_details
                WHERE employee_id = _employee_id
                    AND date >= UNIX_TIMESTAMP()
                    AND date >= _scan_from;

        -- Declare continue handler for cursor end
        DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

        -- Open the cursor
        OPEN cur;

        -- Loop through every apointment found and validate them
        read_loop: LOOP
            FETCH cur INTO date_, start_time_, end_time_, appo_id_;
            
            IF done THEN
                LEAVE read_loop;
            END IF;

            -- find a schedule_id that fits this appoinment
            SET schedule_id_ = fn_validate_appo_by_schedule(_employee_id, date_, start_time_, end_time_);

            -- if no schedule_id returned it means invalid
            IF schedule_id_ IS NOT NULL THEN
                -- create a new schedule_conflict
                INSERT INTO schedule_conflicts(schedule_id_, appo_id_);
            END IF;
        END LOOP;

        -- Close the cursor
        CLOSE cur;

        -- Unlock the table after transaction is complete
        UNLOCK TABLES;

        -- Commit the transaction
    COMMIT;

END;
