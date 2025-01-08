DROP PROCEDURE IF EXISTS sp_get_DELAs_or_appo_lists;

CREATE PROCEDURE sp_get_DELAs_or_appo_lists(
    IN _session JSON,
    IN _date BIGINT,
    IN _service_id INT UNSIGNED,
    IN _selected_AOSO JSON, 
    IN _employee_ids JSON
)
BEGIN    
    -- placeholders
    DECLARE i TINYINT DEFAULT 0;
    DECLARE planned_length_ INT;
    DECLARE service_length_id_ INT UNSIGNED;
    DECLARE employee_id_ INT UNSIGNED;
    DECLARE user_id_ INT UNSIGNED;
    DECLARE role_ VARCHAR(20);
    DECLARE opening_time_ INT;
    DECLARE closing_time_ INT;
    
    -- fetch and validate user's role from session data
    CALL sp_get_user_id_role(_session, user_id_, role_);

    -- IF role is not valid return null and leave procedure
    IF role_ IS NULL
        OR role_ NOT IN ('client','admin', 'developer')
    THEN 
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '401, Unauthorized';
    END IF;

    -- calculate planned length
    CALL sp_calculate_length(
        _service_id, 
        _employee_id, 
        _date, 
        _selected_AOSO, 
        service_length_id_, 
        planned_length_
    );

    -- iterate every employee_id from _employee_ids (json array)
    WHILE i < JSON_LENGTH(_employee_ids) DO 
        -- fetch employee_id
        SET employee_id_ = JSON_UNQUOTE(JSON_EXTRACT(_employee_ids, CONCAT('$[', i, ']')));
        SET i = i + 1;

        -- temporary table: fetch DELA via date & employee & planned length
        CREATE TEMPORARY TABLE DELA_ AS
            SELECT ds.slots
                FROM DELAs d
                    JOIN DELA_slots ds
                    ON d.DELA_id = ds.DELA_id
                WHERE d.date = _date
                    AND d.employee_id = employee_id_
                    AND d.planned_length = planned_length_;

        -- check if DELA is empty 
        IF EXISTS (SELECT 1 FROM DELA_ LIMIT 1) THEN
            -- if DELA not empty, return DELA
            SELECT * FROM DELA_;

        ELSE
            -- fetch opening time and closing time
            CALL sp_get_opening_hours(_employee_id, _date, opening_time_, closing_time_);

            -- if DELA empty, return list of date-employee appointments & planned length & stored intervals
                SELECT NULL, NULL, fn_get_stored_intervals(_employee_id), planned_length_
            UNION ALL
                SELECT opening_time_, closing_time_, NULL, NULL
            UNION ALL
                SELECT start_time, end_time, NULL, NULL
                    FROM appo_details
                    WHERE date = _date
                        AND employee_id = _employee_id
                    ORDER BY start_time;
                
        END IF;

        -- clean up temporary table
        DROP TEMPORARY TABLE IF EXISTS DELA_;

        -- end loop
    END WHILE;
END;
