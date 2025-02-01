DROP PROCEDURE IF EXISTS sp_get_DELAs_or_appo_lists;

CREATE PROCEDURE sp_get_DELAs_or_appo_lists(
    IN _date BIGINT,
    IN _day_of_week INT, -- start at monday = 1, end at sunday = 7
    IN _service_id INT UNSIGNED,
    IN _selected_AOSO JSON, 
    IN _employee_ids JSON
)
BEGIN    
    -- iterator
    DECLARE i INT DEFAULT 0;
    -- variables
    DECLARE planned_length_ INT;
    DECLARE service_length_id_ INT UNSIGNED;
    DECLARE employee_id_ INT UNSIGNED;
    DECLARE opening_time_ INT;
    DECLARE closing_time_ INT;
    DECLARE DELA_id_ INT UNSIGNED;

    -- iterate every employee_id from _employee_ids (json array)
    WHILE i < JSON_LENGTH(_employee_ids) DO 
        -- fetch employee_id
        SET employee_id_ = JSON_UNQUOTE(JSON_EXTRACT(_employee_ids, CONCAT('$[', i, ']')));
        SET i = i + 1;

        -- calculate planned length
        CALL sp_calculate_length(
            _service_id, 
            employee_id_, 
            _date, 
            _selected_AOSO, 
            service_length_id_, 
            planned_length_
        );

        -- temporary table: fetch DELA via date & employee & planned length
        CREATE TEMPORARY TABLE DELA_ AS
            SELECT ds.slot, planned_length_
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

        ELSE -- if DELA empty
            -- fetch opening time and closing time
            CALL sp_get_opening_hours(employee_id_, _date, _day_of_week, opening_time_, closing_time_);

            -- clean the old DELA 
            DELETE FROM DELAs
                WHERE date = _date
                    AND employee_id = employee_id_
                    AND planned_length = planned_length_
                LIMIT 1;

            -- create new DELA_id from this employee_id & date & length
            INSERT INTO DELAs(date, employee_id, planned_length)
                VALUES (_date, employee_id_, planned_length_);
            SET DELA_id_ = LAST_INSERT_ID();

            --  return list of date-employee appointments & planned length & stored intervals & DELA_id
            WITH sorted_appos AS (
                SELECT 
                    start_time AS c1,
                    end_time AS c2,
                    NULL AS c3,
                    NULL AS c4,
                    NULL AS c5
                        FROM appo_details 
                        WHERE date = _date 
                            AND employee_id = employee_id_
                        ORDER BY start_time
            )
                SELECT 
                    NULL AS c1,
                    NULL AS c2,
                    fn_get_stored_intervals(employee_id_) AS c3,
                    planned_length_ AS c4,
                    DELA_id_ AS c5
            UNION ALL
                SELECT 
                    opening_time_ AS c1,
                    closing_time_ AS c2,
                    NULL AS c3,
                    NULL AS c4,
                    NULL AS c5
            UNION ALL
                SELECT * FROM sorted_appos;
           
        END IF;

        -- clean up temporary table
        DROP TEMPORARY TABLE IF EXISTS DELA_;

        -- end loop
    END WHILE;
END;
