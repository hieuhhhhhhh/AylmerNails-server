DROP PROCEDURE IF EXISTS s_add_appo;

CREATE PROCEDURE s_add_appo(
    IN _employee_id INT UNSIGNED,
    IN _service_id INT UNSIGNED,
    IN _start_time BIGINT,
    IN _end_time BIGINT,
    IN _employees_selected VARCHAR(500) DEFAULT NULL,
    IN _created_by_client BOOLEAN DEFAULT TRUE
)
BEGIN
    -- Lock the appo_details table for writing to prevent other transactions from modifying it
    LOCK TABLES appo_details WRITE;

    -- the new appointment must not have duplicate times with others
    -- check if there is any appointment conflicts with this new appointment
    IF EXISTS (
        SELECT 1
        FROM appo_details
        WHERE 
            (_start_time <= start_time AND start_time < _end_time) 
            OR (_start_time < end_time AND end_time <= _end_time)
        LIMIT 1  -- one is enough
    ) THEN
        -- if a conflict exists, refuse to insert new appointment and return NULL 
        SELECT NULL AS new_appo_id;

    ELSE
        -- if no conflicts, add the new appointment
        INSERT INTO appo_details (
            employee_id, 
            service_id, 
            start_time, 
            end_time, 
            employees_selected, 
            created_by_client
        )
        VALUES (
            _employee_id, 
            _service_id, 
            _start_time, 
            _end_time, 
            _employees_selected, 
            _created_by_client
        );

        -- Return the ID of the newly inserted appointment
        SELECT LAST_INSERT_ID() AS new_appo_id;
    END IF;

    -- Unlock the appo_details table
    UNLOCK TABLES;
END;
