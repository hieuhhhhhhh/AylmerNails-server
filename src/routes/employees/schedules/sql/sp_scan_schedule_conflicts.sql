DROP PROCEDURE IF EXISTS sp_scan_schedule_conflicts;

CREATE PROCEDURE sp_scan_schedule_conflicts(
    IN _employee_id INT UNSIGNED,
    IN _scan_from BIGINT
)
BEGIN
    -- variables
    DECLARE scan_to_ INT;

    -- fetch scan_to by next schedule
    SELECT effective_from
        INTO scan_to_
        FROM schedules
        WHERE employee_id = _employee_id
            AND effective_from > _scan_from
        ORDER BY effective_from
        LIMIT 1;

    -- Declare the cursor for fetching the appointment details
    CREATE TEMPORARY TABLE conflicts_ AS 
        SELECT appo_id, fn_find_conflicting_schedule(appo_id) AS schedule_id
            FROM appo_details
            WHERE employee_id = _employee_id
                AND date > (UNIX_TIMESTAMP() - 24*60*60)
                AND date >= _scan_from
                AND date < scan_to_ OR scan_to_ IS NULL;
    

    -- delete old conflicts from last schedules
    DELETE sc
        FROM schedule_conflicts sc
            JOIN appo_details ad 
            ON sc.appo_id = ad.appo_id
        WHERE ad.employee_id = _employee_id 
            AND ad.date >= _scan_from
            AND ad.date < scan_to_ OR scan_to_ IS NULL;

    -- create a new schedule_conflict
    INSERT INTO schedule_conflicts(schedule_id, appo_id)
        SELECT schedule_id, appo_id
            FROM conflicts_
            WHERE schedule_id IS NOT NULL;

END;
