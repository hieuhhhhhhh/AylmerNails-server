DROP PROCEDURE IF EXISTS sp_add_appo_by_DELA;

CREATE PROCEDURE sp_add_appo_by_DELA(
    IN _session JSON,
    IN _employee_id INT UNSIGNED,
    IN _service_id INT UNSIGNED,
    IN _selected_AOSO JSON,
    IN _date BIGINT,
    IN _start_time INT,
    IN _end_time INT,
    IN _employees_selected VARCHAR(500)
)
sp:BEGIN
    -- placeholders
    DECLARE user_id_ INT UNSIGNED;
    DECLARE role_ VARCHAR(20);
    DECLARE service_length_id_ INT UNSIGNED;
    DECLARE planned_length_ INT;
    DECLARE DELA_id_ INT UNSIGNED;

    -- fetch and validate user's role from session data
    CALL sp_get_user_id_role(_session, user_id_, role_);

    -- IF role is not valid return null and leave procedure
    IF role_ IS NULL
        OR role_ NOT IN ('client','admin', 'developer')
    THEN 
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '401, Unauthorized';
    END IF;

    -- calculate length from the given description
    CALL sp_calculate_length(
        _service_id, 
        _employee_id, 
        _date, 
        _selected_AOSO, 
        service_length_id_, 
        planned_length_
    );

    -- fetch the DELA_id that matches the length, date, employee
    SELECT DELA_id
        INTO DELA_id_
        FROM DELAs
        WHERE date = _date
            AND date >= UNIX_TIMESTAMP()
            AND employee_id = _employee_id
            AND planned_length = planned_length_;

    -- check if the start time is valid to a DELA slot
    IF EXISTS(
        SELECT 1 
            FROM DELA_slots
            WHERE DELA_id = DELA_id_
                AND slot = _start_time
    ) 
    THEN 
        -- if the start time matches a DELA slot, add the new appointment
        INSERT INTO appo_details (
            employee_id, 
            service_id, 
            selected_AOSO,
            start_time, 
            end_time
        )
        VALUES (
            _employee_id, 
            _service_id, 
            _selected_AOSO,
            _start_time, 
            _end_time
        );

        -- remove the used DELAs (after a write that DELAs will be invalid)
        DELETE FROM DELAs
            WHERE DELA_id = DELA_id_;
            
        -- Return the ID of the newly inserted appointment
        SELECT LAST_INSERT_ID() AS new_appo_id;
    ELSE
        -- if description not matches any DELA slot, return null
        SELECT NULL;
    END IF;

END;

