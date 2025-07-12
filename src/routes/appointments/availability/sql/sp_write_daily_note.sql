DROP PROCEDURE IF EXISTS sp_write_daily_note;

CREATE PROCEDURE sp_write_daily_note(
    IN _session JSON,
    IN _date BIGINT,
    IN _note VARCHAR(500)
)
BEGIN
    -- validate session token
    CALL sp_validate_admin(_session);

    -- insert / overwrite
    INSERT INTO daily_notes (date, note)
        VALUES (_date, _note)
        ON DUPLICATE KEY UPDATE
            note = VALUES(note);
END;