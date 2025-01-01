-- to be continued

DROP FUNCTION IF EXISTS fn_find_conflicting_length;

CREATE FUNCTION fn_find_conflicting_length(
    _employee_id INT UNSIGNED,
    _date BIGINT,  -- Unix timestamp (BIGINT)
    _start_time INT,  -- Appointment start time
    _end_time INT  -- Appointment end time
)
RETURNS INT UNSIGNED
DETERMINISTIC
BEGIN
    -- 2 endpoints of a time range
    DECLARE opening_time_ INT;
    DECLARE closing_time_ INT;
    DECLARE service_length_id_ INT UNSIGNED;
    DECLARE day_of_week_ INT;

    -- Convert the Unix timestamp (_date) to the day of the week in the Toronto timezone
    -- _date is increase by 43200 seconds (1/2 a day) to shift the time to middle of the day
    SET day_of_week_ = DAYOFWEEK(CONVERT_TZ(FROM_UNIXTIME(_date + 43200), 'UTC', 'America/Toronto'));

    -- fetch most recent schedule of this employee on that date
    SELECT service_length_id
        INTO service_length_id_
        FROM schedules
        WHERE employee_id = _employee_id
            AND effective_from <= UNIX_TIMESTAMP()
        ORDER BY effective_from DESC
        LIMIT 1;

    -- from the service_length_id, fetch the opening and closing time of that day_of_week
    SELECT opening_time, closing_time
        INTO opening_time_, closing_time_
        FROM opening_hours 
        WHERE service_length_id = service_length_id_
            AND day_of_week = day_of_week_
        LIMIT 1;

    -- Return an service_length_id with which the appointment is conflicting
    IF _start_time >= opening_time_ AND _end_time <= closing_time_ THEN
        RETURN NULL;
    ELSE
        RETURN service_length_id_;
    END IF;
END;
