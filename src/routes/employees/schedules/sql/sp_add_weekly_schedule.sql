DROP PROCEDURE IF EXISTS sp_add_weekly_schedule;

CREATE PROCEDURE sp_add_weekly_schedule(
    IN employee_id INT UNSIGNED,
    IN effective_from BIGINT,
    IN opening_hours JSON,
    IN closing_hours JSON,
)
BEGIN
    DECLARE index_ TINYINT;
END;