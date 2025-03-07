DROP FUNCTION IF EXISTS fn_find_conflicting_schedule;

CREATE FUNCTION fn_find_conflicting_schedule(
    _appo_id INT UNSIGNED
)
RETURNS INT UNSIGNED
DETERMINISTIC
BEGIN
    -- variables
    DECLARE schedule_id_ INT UNSIGNED;
    DECLARE conflict_id_ INT UNSIGNED;
    DECLARE date_ BIGINT;
    DECLARE day_of_week_ INT;
    DECLARE start_ INT;
    DECLARE end_ INT;
    DECLARE emp_id_ INT UNSIGNED;


    -- fetch appointment info
    SELECT date, day_of_week, start_time, end_time, employee_id
        INTO date_, day_of_week_, start_, end_, emp_id_
        FROM appo_details
        WHERE appo_id = _appo_id;

    -- fetch latest schedule info
    SELECT schedule_id
        INTO schedule_id_
        FROM schedules
        WHERE employee_id = emp_id_
            AND date_ >= effective_from
        ORDER BY effective_from DESC
        LIMIT 1;
 
    -- fetch opening_hours id
    SELECT schedule_id
        INTO conflict_id_
        FROM opening_hours
        WHERE schedule_id = schedule_id_
            AND day_of_week = day_of_week_
            AND start_ < opening_time
            OR end_ > closing_time;

    RETURN conflict_id_;
END;
