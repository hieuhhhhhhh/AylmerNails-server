DROP PROCEDURE IF EXISTS sp_get_daily_note;

CREATE PROCEDURE sp_get_daily_note(
    IN _session JSON,
    IN _date BIGINT
)
BEGIN
    -- validate session token
    CALL sp_validate_admin(_session);

    -- return note if found, otherwise return NULL
    SELECT (
        SELECT note
            FROM daily_notes
            WHERE date = _date
    ) AS note;
END;