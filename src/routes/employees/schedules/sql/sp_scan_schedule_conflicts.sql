DROP PROCEDURE IF EXISTS sp_scan_schedule_conflicts;

CREATE PROCEDURE sp_scan_schedule_conflicts(
    IN _employee_id INT UNSIGNED,
    IN _scan_from BIGINT
)
BEGIN
    -- loop breaker (escape loop when true)
    DECLARE done BOOLEAN DEFAULT FALSE;

    -- placeholders
    DECLARE schedule_id_ INT UNSIGNED;
    DECLARE appo_id_ INT UNSIGNED;
    DECLARE date_ BIGINT;
    DECLARE start_time_ INT;
    DECLARE end_time_ INT;

    -- Declare the cursor for fetching the appointment details
    DECLARE cur CURSOR FOR
        SELECT date, start_time, end_time, appo_id
            FROM appo_details
            WHERE employee_id = _employee_id
                AND date >= (UNIX_TIMESTAMP() - 24*60*60)
                AND date >= _scan_from;

    -- Declare continue handler for cursor end
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

    -- clean old conflicts from last schedules
    CALL sp_clean_old_schedule_conflicts(_employee_id, _scan_from);

    -- Open the cursor
    OPEN cur;
        -- Loop through every apointment found and validate them
        read_loop: LOOP
            FETCH cur INTO date_, start_time_, end_time_, appo_id_;
            
            IF done THEN
                LEAVE read_loop;
            END IF;

            -- find a schedule_id that conflict with this appoinment
            SET schedule_id_ = fn_find_conflicting_schedule(_employee_id, date_, start_time_, end_time_);

            -- if a schedule_id returned it means invalid
            IF schedule_id_ IS NOT NULL THEN
                -- create a new schedule_conflict
                INSERT INTO schedule_conflicts(schedule_id, appo_id)
                    VALUES (schedule_id_, appo_id_);
            END IF;
        END LOOP;

        -- Close the cursor
    CLOSE cur;

END;
