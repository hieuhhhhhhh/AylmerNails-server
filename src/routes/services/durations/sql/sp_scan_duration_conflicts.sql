DROP PROCEDURE IF EXISTS sp_scan_duration_conflicts;

CREATE PROCEDURE sp_scan_duration_conflicts(
    IN _service_id INT UNSIGNED
)
BEGIN    
    DECLARE last_date_ BIGINT;
    DECLARE today_ BIGINT;

    -- remove old conflicts
    DELETE 
        FROM duration_conflicts
        WHERE service_id = _service_id;

    -- fetch last date of service
    SELECT last_date
        INTO last_date_
        FROM services
        WHERE service_id = _service_id;

    -- scan all appos that not match calculated duration
    SET today_ = UNIX_TIMESTAMP() - 24*60*60;

    INSERT INTO duration_conflicts (service_id, appo_id)
        SELECT service_id, appo_id
            FROM appo_details 
            WHERE date > today_
                AND (date <= last_date_ OR last_date_ IS NULL)
                AND end_time - start_time != fn_calculate_appo_duration(appo_id);
END;