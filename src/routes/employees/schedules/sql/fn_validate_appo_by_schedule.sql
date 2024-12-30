DROP FUNCTION IF EXISTS fn_validate_appo_by_schedule;

CREATE FUNCTION fn_validate_appo_by_schedule(
    _employee_id INT UNSIGNED,
    _day_of_week TINYINT, 
    _start_time INT,
    _end_time INT
)
RETURNS BOOLEAN
DETERMINISTIC
BEGIN
    -- 2 endpoints of a time range
    DECLARE opening_time_ INT;
    DECLARE closing_time_ INT;

    -- fetch from most recent schedule of this employee
    SELECT opening_time, closing_time
        INTO opening_time_, closing_time_
        FROM opening_hours oh JOIN schedules 
            ON oh.shedule_id = s.schedule_id 
        WHERE s.employee_id = _employee_id
            AND s.effective_from <= UNIX_TIMESTAMP()
        ORDER BY s.effective_from DESC
        LIMIT 1;

    -- Return true if the appointment time is within the opening and closing time
    IF _start_time >= opening_time_ AND _end_time <= closing_time_ THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;

