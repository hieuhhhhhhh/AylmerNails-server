DROP PROCEDURE IF EXISTS sp_find_add_schedule_conflicts;

CREATE PROCEDURE sp_find_add_schedule_conflicts(
    IN _employee_id INT UNSIGNED,
    IN _effective_from BIGINT
)
BEGIN
    DECLARE done TINYINT DEFAULT 0;
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
                AND date >= UNIX_TIMESTAMP()
                AND date >= _effective_from;

    -- Declare continue handler for cursor end
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    -- Open the cursor
    OPEN cur;

    -- Loop through the rows returned by the cursor
    read_loop: LOOP
        FETCH cur INTO date_, start_time_, end_time_, appo_id_;
        
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- Validate schedule using the function (replace this with your actual function)
        SET schedule_id_ = fn_validate_appo_by_schedule(_employee_id, date_, start_time_, end_time_);

        -- Check if the schedule is not null
        IF schedule_id_ IS NOT NULL THEN
            -- Insert into the conflicts table
            INSERT INTO schedule_conflicts(schedule_id_, appo_id_);
        END IF;
    END LOOP;

    -- Close the cursor
    CLOSE cur;

END;
