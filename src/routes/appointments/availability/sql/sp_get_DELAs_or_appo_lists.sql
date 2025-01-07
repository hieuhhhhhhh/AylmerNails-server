DROP PROCEDURE IF EXISTS sp_get_DELAs_or_appo_lists;

CREATE PROCEDURE sp_get_DELAs_or_appo_lists(
    IN _date BIGINT,
    IN _service_id INT UNSIGNED,
    IN _employee_ids JSON
)
BEGIN
    -- placeholders
    DECLARE planned_length_ INT,

    -- calculate length
    CALL sp_calculate_length(
        _service_id, 
        _employee_id, 
        _date, 
        _selected_AOSO, 
        service_length_id_, 
        planned_length_
    );

    -- Step 1: Create a temporary table (if not already created)
    CREATE TEMPORARY TABLE DELAs AS
    SELECT column1, column2
    FROM your_table
    WHERE some_condition;

    -- Step 2: Check if at least one row exists in the temporary table
    IF EXISTS (SELECT 1 FROM temp_table LIMIT 1) THEN
        -- The table is not empty, so perform your SELECT query
        SELECT * FROM temp_table;
    ELSE
        -- The table is empty
        SELECT 'The table is empty' AS message;
    END IF;

    -- Step 3: (Optional) Drop the temporary table when done
    DROP TEMPORARY TABLE IF EXISTS temp_table;

END;
