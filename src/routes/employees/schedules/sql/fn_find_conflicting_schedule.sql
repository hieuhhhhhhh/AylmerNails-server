DROP FUNCTION IF EXISTS fn_find_conflicting_schedule;

CREATE FUNCTION fn_find_conflicting_schedule(
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
    DECLARE schedule_id_ INT UNSIGNED;
    DECLARE day_of_week_ INT;

    -- fetch the opening and closing time of that day_of_week
    CALL sp_get_opening_hours(_employee_id,_date, day_of_week_, opening_time_, closing_time_);

    -- Return an schedule_id with which the appointment violates
    IF _start_time >= opening_time_ AND _end_time <= closing_time_ THEN
        RETURN NULL;
    ELSE
        RETURN schedule_id_;
    END IF;
END;
