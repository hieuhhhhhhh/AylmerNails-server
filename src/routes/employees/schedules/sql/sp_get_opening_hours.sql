DROP PROCEDURE IF EXISTS sp_get_opening_hours;

CREATE PROCEDURE sp_get_opening_hours(
    IN _employee_id INT UNSIGNED,
    IN _date BIGINT,
    IN _day_of_week BIGINT,  -- start at monday = 1, end at sunday = 7
    OUT _opening_time INT, 
    OUT _closing_time INT  
)
BEGIN
    -- placeholders
    DECLARE schedule_id_ INT UNSIGNED;

    -- fetch most recent schedule of this employee from inputted date
    SELECT schedule_id
        INTO schedule_id_
        FROM schedules
        WHERE employee_id = _employee_id
            AND effective_from <= _date
        ORDER BY effective_from DESC
        LIMIT 1;

    -- from the schedule_id, fetch the opening and closing time via day_of_week & schedule_id
    SELECT opening_time, closing_time
        INTO _opening_time, _closing_time
        FROM opening_hours 
        WHERE schedule_id = schedule_id_
            AND day_of_week = _day_of_week
        LIMIT 1;

END;
