DROP PROCEDURE IF EXISTS sp_scan_schedule_conflicts;

CREATE PROCEDURE sp_scan_schedule_conflicts(
    IN _employee_id INT UNSIGNED,
    IN _effective_from BIGINT
)
BEGIN    
    -- variables
    DECLARE today_ BIGINT;
    SET today_ = UNIX_TIMESTAMP() - 24*60*60;

    -- remove old conflicts from the effective_from
    DELETE sc
        FROM schedule_conflicts sc
            JOIN schedules s
                ON s.schedule_id = sc.schedule_id
            JOIN appo_details ad
                ON ad.appo_id = sc.appo_id
        WHERE s.employee_id = _employee_id
            AND ad.date >= _effective_from;

    -- filter out appos that have conflicting schedule
    INSERT INTO schedule_conflicts (schedule_id, appo_id)
        SELECT fn_get_conflicting_schedule_id(appo_id), appo_id
            FROM appo_details 
            WHERE employee_id = _employee_id
                AND date > today_
                AND date >= _effective_from
                AND fn_get_conflicting_schedule_id(appo_id) IS NOT NULL;
END;