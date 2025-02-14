DROP PROCEDURE IF EXISTS sp_get_daily_appos;

CREATE PROCEDURE sp_get_daily_appos(
    IN _session JSON,
    IN _date BIGINT 
)
sp:BEGIN    
    -- validate session token
    CALL sp_validate_admin(_session);
    
    -- return all appos of that date, sorted by employee_id
    SELECT * 
        FROM appo_details 
        WHERE date = _date
        ORDER BY employee_id;            
END;

