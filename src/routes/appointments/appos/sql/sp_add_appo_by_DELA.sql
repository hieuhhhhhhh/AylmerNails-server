DROP PROCEDURE IF EXISTS sp_add_appo_by_DELA;

CREATE PROCEDURE sp_add_appo_by_DELA(
    IN _session JSON,
    IN _employee_id INT UNSIGNED,
    IN _service_id INT UNSIGNED,
    IN _selected_AOSO JSON,
    IN _date BIGINT,
    IN _start_time INT
)
BEGIN
    -- placeholders
    DECLARE service_length_id_ INT UNSIGNED;
    DECLARE planned_length_ INT;
    DECLARE DELA_id_ INT UNSIGNED;

    -- validate session token
    CALL sp_validate_client(_session);

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
            AND date > UNIX_TIMESTAMP() - 24*60*60
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
        -- remove the used DELA (after a write that DELAs will be invalid)
        DELETE FROM DELAs
            WHERE DELA_id = DELA_id_;

        -- if the start time matches a DELA slot, add the new appointment
        INSERT INTO appo_details (
            employee_id, 
            service_id, 
            selected_AOSO,
            date,
            start_time, 
            end_time
        )
        VALUES (
            _employee_id, 
            _service_id, 
            _selected_AOSO,
            _date,
            _start_time, 
            _start_time + planned_length_
        );
            
        -- Return the ID of the newly inserted appointment
        SELECT LAST_INSERT_ID() AS new_appo_id;
    ELSE
        -- if description not matches any DELA slot, return exception
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = '400, not in DELA';
    END IF;

END;

