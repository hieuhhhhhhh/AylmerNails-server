DROP PROCEDURE IF EXISTS sp_get_employee_schedules;

CREATE PROCEDURE sp_get_employee_schedules(
    IN _employee_id INT UNSIGNED
)
BEGIN
    SELECT 
        oh.day_of_week,
        oh.opening_time,
        oh.closing_time,
        oh.schedule_id,
        s.effective_from
            FROM opening_hours oh
                JOIN schedules s
                    ON oh.schedule_id = s.schedule_id
            WHERE s.employee_id = _employee_id
            ORDER BY s.effective_from, oh.day_of_week;
END;