DROP PROCEDURE IF EXISTS sp_get_opening_hours;

CREATE PROCEDURE sp_get_opening_hours(
    IN _employee_id INT UNSIGNED,
    IN _date BIGINT,  -- Unix timestamp (BIGINT)
    OUT _opening_time INT, 
    OUT _closing_time INT  
)
BEGIN
    -- placeholders
    DECLARE schedule_id_ INT UNSIGNED;
    DECLARE day_of_week_ INT;

    -- Convert the Unix timestamp (_date) to the day of the week in the Toronto timezone
    -- _date is increase by 43200 seconds (1/2 a day) to shift the time to middle of the day
    SET day_of_week_ = DAYOFWEEK(CONVERT_TZ(FROM_UNIXTIME(_date + 43200), 'UTC', 'America/Toronto'));

    -- fetch most recent schedule of this employee from inputted date
    SELECT schedule_id
        INTO schedule_id_
        FROM schedules
        WHERE employee_id = _employee_id
            AND effective_from <= UNIX_TIMESTAMP()
        ORDER BY effective_from DESC
        LIMIT 1;

    -- from the schedule_id, fetch the opening and closing time via day_of_week & schedule_id
    SELECT opening_time, closing_time
        INTO _opening_time, _closing_time
        FROM opening_hours 
        WHERE schedule_id = schedule_id_
            AND day_of_week = day_of_week_
        LIMIT 1;

END;
