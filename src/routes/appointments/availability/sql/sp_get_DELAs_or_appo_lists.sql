DROP PROCEDURE IF EXISTS sp_get_DELAs_or_appo_lists;

CREATE PROCEDURE sp_get_DELAs_or_appo_lists(
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

        -- fetch DELA via date & employee & planned length
        CREATE TEMPORARY TABLE DELA AS
            SELECT ds.slots
                FROM DELAs d
                    JOIN DELA_slots ds
                    ON d.DELA_id = ds.DELA_id
                WHERE d.date = _date
                    AND d.employee_id = employee_id_
                    AND d.planned_length = planned_length_;

        -- check if DELA is empty 
        IF EXISTS (SELECT 1 FROM DELA LIMIT 1) THEN
            -- if DELA not empty, return DELA
            SELECT * FROM DELA;
        ELSE
            -- if DELA empty, return list of date-employee appointments & planned length & stored intervals
            SELECT 'The table is empty' AS message;
        END IF;

        -- clean up
        DROP TEMPORARY TABLE IF EXISTS DELA;

        -- end loop
    END WHILE;
END;
