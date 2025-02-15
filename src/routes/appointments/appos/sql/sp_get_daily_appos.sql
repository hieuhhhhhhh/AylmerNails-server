DROP PROCEDURE IF EXISTS sp_get_daily_appos;

CREATE PROCEDURE sp_get_daily_appos(
    IN _session JSON,
    IN _date BIGINT 
)
sp:BEGIN    
    -- validate session token
    CALL sp_validate_admin(_session);
    
    -- return all appos of that date, sorted by employee_id
    SELECT ad.*, e.alias, c.code
        FROM appo_details ad
            LEFT JOIN employees e    
                ON ad.employee_id = e.employee_id
            LEFT JOIN colors c    
                ON c.color_id = e.color_id
        WHERE ad.date = _date
        ORDER BY ad.employee_id, ad.start_time;            
END;

