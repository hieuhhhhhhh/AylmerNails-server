DROP PROCEDURE IF EXISTS sp_get_service_details;

CREATE PROCEDURE sp_get_service_details(
    IN _service_id INT UNSIGNED
)
BEGIN
    -- placeholders
    DECLARE service_length_id_ INT UNSIGNED;
    DECLARE effective_from_ BIGINT;
    DECLARE length_ INT;

    -- loop breaker
    DECLARE done_ BOOLEAN DEFAULT FALSE;    

    -- fetch all service_lengths to a cursor
    DECLARE cur_ CURSOR FOR
        SELECT service_length_id, effective_from, length
            FROM service_lengths
            WHERE service_id = _service_id
                ORDER BY effective_from DESC;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done_ = TRUE;

    -- return table: service details
    SELECT s.service_id, s.name, s.description, s.last_date, s.category_id, c.name
        FROM services s 
            LEFT JOIN categories c
                ON s.category_id = c.category_id
        WHERE s.service_id = _service_id;

    -- Open the cursor
    OPEN cur_;
        -- Fetch 1st row from the cursor into variables
        FETCH cur_ INTO service_length_id_, effective_from_, length_;    

        -- loop
        WHILE NOT done_ DO
            -- return 1st table: length details
            SELECT effective_from_, length_;

            -- return 2nd table: all variations of the previous length
            SELECT employee_id, length_offset
                FROM SLVs
                WHERE service_length_id = service_length_id_;

            -- Fetch next row from the cursor into variables, repeat the process on next length
            FETCH cur_ INTO service_length_id_, effective_from_, length_;            
        END WHILE;

        -- Close the cursor
    CLOSE cur_;
END;
