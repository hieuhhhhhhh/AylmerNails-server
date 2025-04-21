DROP PROCEDURE IF EXISTS sp_update_appo;

CREATE PROCEDURE sp_update_appo(
    IN _session JSON,
    IN _appo_id INT UNSIGNED,
    IN _phone_num VARCHAR(15),
    IN _name VARCHAR(200),
    IN _name_tokens JSON,
    IN _emp_id INT UNSIGNED,
    IN _service_id INT UNSIGNED,
    IN _AOSOs JSON,
    IN _date BIGINT,
    IN _day_of_week INT,
    IN _start INT,
    IN _end INT,
    IN _selected_emps JSON,
    IN _note VARCHAR(500)
)
sp:BEGIN
    -- variables
    DECLARE appo_id_ INT UNSIGNED;
    DECLARE start_ INT;
    DECLARE end_ INT;
    DECLARE schedule_id_ INT UNSIGNED;
    DECLARE day_start_ INT;
    DECLARE day_end_ INT;
    DECLARE phone_num_id_ INT UNSIGNED;

    -- validate session token
    CALL sp_validate_admin(_session);

    -- save
    SAVEPOINT s1;

    -- update contact 
    CALL sp_update_contact (_phone_num, _name, _name_tokens, phone_num_id_);

    -- remove last appointment
    DELETE FROM appo_details
        WHERE appo_id = _appo_id;

    -- check overlaps 
    SELECT appo_id, start_time, end_time
        INTO appo_id_, start_, end_
        FROM appo_details
        WHERE date = _date
            AND employee_id = _emp_id
            AND NOT (end_time <= _start OR _end <= start_time)            
        LIMIT 1;

    -- return overlap details
    SELECT appo_id_, start_, end_;

    -- if overlap exists, leave procedure
    IF appo_id_ IS NOT NULL THEN       
        ROLLBACK TO SAVEPOINT s1;
        LEAVE sp;        
    END IF;

    -- fetch matching schedule of employee
    SELECT oh.opening_time, oh.closing_time, oh.schedule_id
        INTO day_start_, day_end_, schedule_id_
        FROM opening_hours oh
            JOIN schedules s 
                ON s.schedule_id = oh.schedule_id
        WHERE s.employee_id = _emp_id 
            AND oh.day_of_week = _day_of_week
            AND _date >= s.effective_from
        ORDER BY s.effective_from DESC
        LIMIT 1;
            
    -- check if new appointment in schedule range
    IF _start >= day_start_ AND _end <= day_end_ THEN
        -- return null if valid
        SELECT NULL, NULL, NULL;
    ELSE
        -- return conflict schedule, leave procedure
        SELECT schedule_id_, day_start_, day_end_;
        ROLLBACK TO SAVEPOINT s1;
        LEAVE sp;
    END IF;

    -- create new appointment if all validations passed
    INSERT INTO appo_details (employee_id, service_id, phone_num_id, selected_AOSO, date, day_of_week, start_time, end_time)
        VALUES (_emp_id, _service_id, phone_num_id_, _AOSOs, _date, _day_of_week, _start, _end);

    -- save appointment's selected employees
    CALL sp_save_appo_employees(LAST_INSERT_ID(), _selected_emps);

    -- return created appo_id
    SELECT LAST_INSERT_ID();
END;

