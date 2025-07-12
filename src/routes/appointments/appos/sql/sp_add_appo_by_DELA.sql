DROP PROCEDURE IF EXISTS sp_add_appo_by_DELA;

CREATE PROCEDURE sp_add_appo_by_DELA(
    IN _phone_num_id INT UNSIGNED,
    IN _booker_id INT UNSIGNED,
    IN _employee_id INT UNSIGNED,
    IN _service_id INT UNSIGNED,
    IN _selected_AOSO JSON,
    IN _date BIGINT,
    IN _day_of_week INT,
    IN _start_time INT,
    IN _selected_emps JSON,
    IN _message VARCHAR(500)
)
BEGIN
    -- placeholders
    DECLARE planned_length_ INT;
    DECLARE DELA_id_ INT UNSIGNED;

    -- validate add appo rate limit
    IF (
        SELECT COUNT(*) 
            FROM appo_notifications 
                JOIN appo_details 
                    ON appo_notifications.appo_id = appo_details.appo_id
                LEFT JOIN authentication
                    ON authentication.phone_num_id = appo_details.phone_num_id
            WHERE (role NOT IN ('admin', 'owner') OR role IS NULL)
                AND appo_details.phone_num_id = _phone_num_id
                AND appo_notifications.time >= UNIX_TIMESTAMP() - 24*60*60
    ) > 3
    THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Maximun appointments reached today. Please try again next time';
    END IF;

    -- calculate length from the given description
    SET planned_length_ = fn_calculate_duration(
        _service_id, 
        _employee_id,             
        _selected_AOSO
    );

    -- fetch the DELA_id that matches the length, date, employee
    SELECT DELA_id
        INTO DELA_id_
        FROM DELAs
        WHERE date = _date
            AND date > UNIX_TIMESTAMP() - 24*60*60
            AND employee_id = _employee_id
            AND planned_length = planned_length_; 

    -- check if the start time is valid to a DELA slot
    IF EXISTS(
        SELECT 1 
            FROM DELA_slots
            WHERE DELA_id = DELA_id_
                AND slot = _start_time
    ) OR EXISTS (
        SELECT 1
            FROM appo_details
            WHERE date = _date
                AND employee_id = _employee_id
                AND end_time = _start_time
    )
    THEN
        -- remove the used DELA (a DELA is for one time use)
        DELETE FROM DELA_slots
            WHERE DELA_id = DELA_id_
                AND slot = _start_time;

        -- if the start time matches a DELA slot, add the new appointment
        INSERT INTO appo_details (
            employee_id, 
            service_id, 
            phone_num_id,
            selected_AOSO,
            date,
            day_of_week,
            start_time, 
            end_time,
            message,
            booker_id
        )
        VALUES (
            _employee_id, 
            _service_id,
            _phone_num_id,
            _selected_AOSO,
            _date,
            _day_of_week,
            _start_time, 
            _start_time + planned_length_,
            _message,
            _booker_id
        );

        -- save appointment's selected employees
        CALL sp_save_appo_employees(LAST_INSERT_ID(), _selected_emps);

        -- Return the ID of the newly inserted appointment
        SELECT LAST_INSERT_ID(), c.name, p.value
            FROM contacts c
                JOIN phone_numbers p
                    ON p.phone_num_id = c.phone_num_id
            WHERE c.phone_num_id = _phone_num_id;

        -- create new notification
        INSERT INTO appo_notifications (appo_id)
            VALUES (LAST_INSERT_ID());    

    ELSE
        -- if description not matches any DELA slot, return exception
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'The selected time is no longer available, please refresh page and try again';
    END IF;

END;

