DROP PROCEDURE IF EXISTS sp_clean_old_schedule_conflicts;

CREATE PROCEDURE sp_clean_old_schedule_conflicts(
    IN _employee_id INT UNSIGNED,
    IN _effective_from BIGINT
)
BEGIN
    -- Deleting rows from schedule_conflicts where the date in appo_details is >= _effective_from
    DELETE sc
        FROM schedule_conflicts sc
            JOIN appo_details ad 
            ON sc.appo_id = ad.appo_id
        WHERE ad.employee_id = _employee_id 
            AND ad.date >= _effective_from;
END;
