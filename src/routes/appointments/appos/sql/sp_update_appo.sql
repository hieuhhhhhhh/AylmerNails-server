DROP PROCEDURE IF EXISTS sp_update_appo;

CREATE PROCEDURE sp_update_appo(
    IN _appo_id INT UNSIGNED,
    IN _emp_id INT UNSIGNED,
    IN _service_id INT UNSIGNED,
    IN _AOSOs JSON,
    IN _date BIGINT,
    IN _start INT,
    IN _end INT,
    IN _note VARCHAR(500)
)
sp:BEGIN
    -- variables
    DECLARE appo_id_ INT UNSIGNED;
    DECLARE start_ INT;
    DECLARE end_ INT;
    DECLARE day_start_ INT;
    DECLARE day_end_ INT;

    -- validate session token
    CALL sp_validate_admin(_session);

    -- save
    SAVEPOINT s1;

    -- remove last appointment
    DELETE FROM appo_details
        WHERE appo_id = _appo_id;

    -- check overlaps 
    SELECT appo_id, start, end
        INTO appo_id_, start_, end_
        FROM appo_details
        WHERE date = _date
            AND employee_id = _emp_id
            AND (start_time >= _start AND start_time < _end)
            OR (end_time > _start AND end_time <= end)
        LIMIT 1;

    -- return overlap details
    SELECT appo_id_, start_, end_;

    -- if overlap exists, leave procedure
    IF appo_id_ IS NOT NULL THEN       
        ROLLBACK TO SAVEPOINT s1;
        LEAVE sp;        
    END IF;

    -- fetch matching schedule of employee
    SELECT oh.opening_time, oh.closing_time
        INTO day_start_, day_end_
        FROM opening_hours oh
            JOIN schedules s 
                ON s.schedule_id = oh.schedule_id
        WHERE _date >= s.effective_from
        ORDER BY s.effective_from DESC
        LIMIT 1;
            
    -- if new appointment not in schedule range, leave procedure
    IF _start < day_start_ OR _end > day_end_ THEN
        -- return conflict schedule
        ROLLBACK TO SAVEPOINT s1;
        SELECT day_start_, day_end_;
        LEAVE sp;
    ELSE
        -- return null if valid
        SELECT NULL, NULL;
    END IF;

    -- create new appointment if all validations passed
    INSERT INTO appo_details (employee_id, service_id, selected_AOSO, date, start_time, end_time)
        VALUES (_emp_id, _service_id, _AOSOs, _date, _start, _end);

    -- return created appo_id
    SELECT LAST_INSERT_ID();
END;

