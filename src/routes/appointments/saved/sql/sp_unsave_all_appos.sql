DROP PROCEDURE IF EXISTS sp_unsave_all_appos;

CREATE PROCEDURE sp_unsave_all_appos(
    IN _session JSON
)
BEGIN    
    -- validate session token
    CALL sp_validate_admin(_session);    

    -- delete all rows 
    TRUNCATE TABLE saved_appos;
END;