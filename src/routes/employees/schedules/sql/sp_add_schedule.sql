DROP PROCEDURE IF EXISTS sp_add_schedule;

CREATE PROCEDURE sp_add_schedule(
    IN _employee_id INT UNSIGNED,
    IN _effective_from BIGINT,
    IN _opening_times JSON, -- array of opening times from sunday (index 0) to saturday (index 6)
    IN _closing_times JSON, -- array of closing times from sunday (index 0) to saturday (index 6)
)
BEGIN
    -- declare an index starts from 0 ~ sunday to 6 ~ saturday
    DECLARE i TINYINT DEFAULT 0; 
    
    -- placeholders
    DECLARE opening_time_ INT;
    DECLARE closing_time_ INT;
    DECLARE schedule_id_ INT UNSIGNED;

    -- add a new schedule
    INSERT INTO schedules(employee_id, effective_from)
        VALUES (_employee_id, _effective_from);

    -- fetch the newly created schedule_id
    SET schedule_id_ = LAST_INSERT_ID();

    -- start iterating to generate opening hours that reference the new schedule_id
    WHILE i <= 6 DO 
        SET opening_time_ = JSON_UNQUOTE(JSON_EXTRACT(_opening_times, CONCAT('$[', i, ']')));
        SET closing_time_ = JSON_UNQUOTE(JSON_EXTRACT(_closing_times, CONCAT('$[', i, ']')));

        -- store values to opening_hours table
        INSERT INTO opening_hours (schedule_id, day_of_week, opening_time, closing_time)
            VALUES (schedule_id_, i, opening_time_, closing_time_);

        -- increment index
        SET i = i + 1;
    END WHILE;


END;