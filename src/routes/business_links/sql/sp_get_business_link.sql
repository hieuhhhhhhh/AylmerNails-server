DROP PROCEDURE IF EXISTS sp_get_business_link;

CREATE PROCEDURE sp_get_business_link()
BEGIN        
    -- return links
    SELECT *
        FROM business_links;
END;