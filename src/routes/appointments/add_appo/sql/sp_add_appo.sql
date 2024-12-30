-- this one will be re-made

DROP PROCEDURE IF EXISTS sp_add_appo;

CREATE PROCEDURE sp_add_appo(
    IN _employee_id INT UNSIGNED,
    IN _service_id INT UNSIGNED,
    IN _date BIGINT,
    IN _start_time INT,
    IN _end_time INT,
    IN _employees_selected VARCHAR(500),
    IN _created_by_client BOOLEAN DEFAULT TRUE
)
BEGIN
    -- Ensure that the table is unlocked in case of an error
    DECLARE error_handler HANDLER FOR SQLEXCEPTION
    BEGIN
        UNLOCK TABLES;
    END;

    -- Lock the appo_details table for writing to prevent other transactions from modifying it
    LOCK TABLES appo_details WRITE;

    -- the new appointment must not have duplicate times with other appointments of that employee
    IF EXISTS (
        SELECT employee_id
        FROM appo_details
        WHERE 
            (
                (_start_time <= start_time AND start_time < _end_time) 
                OR (_start_time < end_time AND end_time <= _end_time)
            ) AND employee_id = _employee_id  
        LIMIT 1  -- one row found is enough to indicate it is invalid

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


-- Revoke INSERT and UPDATE permissions on the appo_details table from the root user
REVOKE INSERT, UPDATE ON appo_details FROM 'root'@'%';

-- Grant EXECUTE permission on the stored procedure to the root user
GRANT EXECUTE ON PROCEDURE sp_add_appo TO 'root'@'%';

-- Grant SELECT (read) and DELETE permissions on appo_details table to the root user
GRANT SELECT, DELETE ON appo_details TO 'root'@'%';


FLUSH PRIVILEGES;
