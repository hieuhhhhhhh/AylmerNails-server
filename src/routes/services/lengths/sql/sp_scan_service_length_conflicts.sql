-- this proc find and store all apointments that conflict with service_lengths

DROP PROCEDURE IF EXISTS sp_scan_service_length_conflicts;

CREATE PROCEDURE sp_scan_service_length_conflicts(
    IN _service_id INT UNSIGNED,
    IN _scan_from BIGINT
)
BEGIN
    -- loop breaker (escape loop when true)
    DECLARE done_ BOOLEAN DEFAULT FALSE;    

    -- placeholders
    DECLARE service_length_id_ INT UNSIGNED;
    DECLARE appo_id_ INT UNSIGNED;
    DECLARE employee_id_ INT UNSIGNED;
    DECLARE date_ BIGINT;
    DECLARE start_time_ INT;
    DECLARE end_time_ INT;
    
    -- Declare the cursor for fetching the appointment details
    DECLARE cur CURSOR FOR
        SELECT date, start_time, end_time, appo_id, employee_id
            FROM appo_details
            WHERE service_id = _service_id
                AND date >= (UNIX_TIMESTAMP() - 24*60*60)
                AND date >= _scan_from;

    -- Declare continue handler for cursor end
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done_ = TRUE;

    -- Clean old conflicts
    DELETE slc
        FROM service_length_conflicts slc
            JOIN appo_details ad 
            ON slc.appo_id = ad.appo_id
        WHERE ad.date >= _scan_from;

    -- Open the cursor
    OPEN cur;
        -- Loop through every apointment found and validate them
        read_loop: LOOP
            FETCH cur INTO date_, start_time_, end_time_, appo_id_, employee_id_;
            
            IF done_ THEN
                LEAVE read_loop;
            END IF;

            -- find a service_length_id that is conflicting this appoinment
            SET service_length_id_ = fn_find_conflicting_length(_service_id, employee_id_, date_, start_time_, end_time_);

            -- if a id is returned it means invalid appointment
            IF service_length_id_ IS NOT NULL 
            THEN
                -- create a new service_length_conflict
                INSERT INTO service_length_conflicts(service_length_id, appo_id) 
                VALUES (service_length_id_, appo_id_);
            END IF;
        END LOOP;
        -- Close the cursor
    CLOSE cur;

END;
