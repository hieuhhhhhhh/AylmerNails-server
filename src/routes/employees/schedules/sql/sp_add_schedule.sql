DROP PROCEDURE IF EXISTS sp_add_schedule;

CREATE PROCEDURE sp_add_schedule(
    IN _session JSON,
    IN _employee_id INT UNSIGNED,
    IN _effective_from BIGINT,
    IN _opening_times JSON, -- array of opening times from monday (index 1) to sunday (index 7)
    IN _closing_times JSON -- array of closing times from monday (index 1) to sunday (index 7)
)
BEGIN    
    -- placeholders
    DECLARE i INT DEFAULT 0; 
    DECLARE opening_time_ INT;
    DECLARE closing_time_ INT;
    DECLARE schedule_id_ INT UNSIGNED;

    -- validate session token
    CALL sp_validate_admin(_session);

    -- delete any old schedule that has same effective_from
    DELETE FROM schedules
        WHERE employee_id = _employee_id  
            AND effective_from = _effective_from;

    -- delete any DELAs of this employee beyond effective_from
    DELETE FROM DELAs
        WHERE employee_id = _employee_id  
            AND date >= _effective_from - 24*60*60;

    -- add a new schedule
    INSERT INTO schedules(employee_id, effective_from)
        VALUES (_employee_id, _effective_from);

    -- fetch the newly created schedule_id
    SET schedule_id_ = LAST_INSERT_ID();

    -- start iterating to generate opening hours that reference the new schedule_id
    WHILE i < 7 DO 
        SET opening_time_ = JSON_UNQUOTE(JSON_EXTRACT(_opening_times, CONCAT('$[', i, ']')));
        SET closing_time_ = JSON_UNQUOTE(JSON_EXTRACT(_closing_times, CONCAT('$[', i, ']')));

        -- store values to opening_hours table
        INSERT INTO opening_hours (schedule_id, day_of_week, opening_time, closing_time)
            VALUES (schedule_id_, i + 1, opening_time_, closing_time_);

        -- increment index
        SET i = i + 1;
    END WHILE;

    -- scan and clean conflicts after finishing adding new schedule with AOSs
    CALL sp_scan_schedule_conflicts(_employee_id, _effective_from);

    -- return the added schedule_id
    SELECT schedule_id_;

END;