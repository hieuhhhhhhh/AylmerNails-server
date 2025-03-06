DROP PROCEDURE IF EXISTS sp_scan_duration_conflicts;

CREATE PROCEDURE sp_scan_duration_conflicts(
    IN _service_id INT UNSIGNED
)
BEGIN    
    DECLARE last_date_ BIGINT;

    -- fetch last date of service
    SELECT last_date
        INTO last_date_
        FROM services
        WHERE service_id = _service_id;

    -- scan all appos that not match calculated duration
    INSERT INTO duration_conflicts (service_id, appo_id)
        SELECT service_id, appo_id
            FROM appo_details 
            WHERE date > UNIX_TIMESTAMP() - 24*60*60
                AND date <= last_date
                AND start_time - end_time != fn_calculate_appo_duration(appo_id);
END;