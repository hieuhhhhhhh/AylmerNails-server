DROP PROCEDURE IF EXISTS sp_write_appo_note;

CREATE PROCEDURE sp_write_appo_note(
    IN _session JSON,
    IN _appo_id INT UNSIGNED,
    IN _note VARCHAR(500)
)
BEGIN
    -- validate session token
    CALL sp_validate_admin(_session);

    -- insert / overwrite
    INSERT INTO appo_notes (appo_id, note)
        VALUES (_appo_id, _note)
        ON DUPLICATE KEY UPDATE
            note = VALUES(note);
END;