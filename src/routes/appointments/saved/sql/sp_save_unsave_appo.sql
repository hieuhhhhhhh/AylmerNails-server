DROP PROCEDURE IF EXISTS sp_save_unsave_appo;

CREATE PROCEDURE sp_save_unsave_appo(
    IN _session JSON,
    IN _appo_id INT UNSIGNED,
    IN _boolean BOOLEAN
)
BEGIN    
    -- validate session token
    CALL sp_validate_admin(_session);    

    -- insert or delete row
    IF _boolean THEN
        INSERT INTO saved_appos(appo_id)    
            VALUES (_appo_id);
    ELSE
        DELETE FROM saved_appos
            WHERE appo_id = _appo_id;
    END IF;
END;