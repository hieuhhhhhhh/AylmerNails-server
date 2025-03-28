DROP PROCEDURE IF EXISTS sp_get_business_links;

CREATE PROCEDURE sp_get_business_links()
BEGIN        
    -- return links
    SELECT *
        FROM business_links;
END;