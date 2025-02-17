DROP PROCEDURE IF EXISTS sp_get_daily_appos;

CREATE PROCEDURE sp_get_daily_appos(
    IN _session JSON,
    IN _date BIGINT,
    IN _day_of_week INT 
)
sp:BEGIN    
    -- validate session token
    CALL sp_validate_admin(_session);
    
    -- 1st table: return all appos of that date, sorted by employee_id
    SELECT *
        FROM appo_details 
        WHERE date = _date
        ORDER BY employee_id, start_time;  

    -- get most recent schedule of every employee
    CREATE TEMPORARY TABLE emp_max_ef_ AS
        SELECT employee_id, MAX(effective_from) AS max_ef
            FROM schedules
            WHERE effective_from <= _date
            GROUP BY employee_id; 

    CREATE TEMPORARY TABLE schedules_ AS
        SELECT s.schedule_id, e.employee_id, e.max_ef
            FROM schedules s
                JOIN emp_max_ef_ e
                    ON e.employee_id = s.employee_id
                        AND e.max_ef = s.effective_from;

    -- get opening hours of all available employees
    CREATE TEMPORARY TABLE opening_hours_ AS
        SELECT oh.opening_time, oh.closing_time, oh.day_of_week, oh.schedule_id, s.employee_id, s.max_ef
            FROM opening_hours oh
                JOIN schedules_ s 
                    ON s.schedule_id = oh.schedule_id
            WHERE oh.day_of_week = _day_of_week;
            

    -- 2nd table: return all employees and their info
    SELECT e.employee_id, e.alias, e.color_id, c.code, oh.opening_time, oh.closing_time, oh.day_of_week, oh.schedule_id, oh.max_ef
        FROM employees e
            JOIN colors c 
                ON e.color_id = c.color_id
            JOIN opening_hours_ oh
                ON e.employee_id = oh.employee_id
        WHERE e.last_date IS NULL 
            OR e.last_date > _date;

        
END;

