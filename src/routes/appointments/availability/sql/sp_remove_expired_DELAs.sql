DROP PROCEDURE IF EXISTS sp_remove_expired_DELAs;

CREATE PROCEDURE sp_remove_expired_DELAs(
    IN _date BIGINT,
    IN _employee_id INT UNSIGNED
)
BEGIN
    -- remove invalid DELAs
    DELETE FROM DELAs
        WHERE date = _date
            AND employee_id = _employee_id;
END;