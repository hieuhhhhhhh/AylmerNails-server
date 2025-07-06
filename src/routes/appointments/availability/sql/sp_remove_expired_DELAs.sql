DROP PROCEDURE IF EXISTS sp_remove_expired_DELAs;

CREATE PROCEDURE sp_remove_expired_DELAs(
    IN _appo_id INT UNSIGNED
)
BEGIN
    -- remove invalid DELAs
    DELETE d
        FROM DELAs d
            JOIN appo_details ad
                ON ad.date = d.date
                AND ad.employee_id = d.employee_id
        WHERE ad.appo_id = _appo_id;
END;