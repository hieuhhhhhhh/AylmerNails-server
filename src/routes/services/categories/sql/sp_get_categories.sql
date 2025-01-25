DROP PROCEDURE IF EXISTS sp_get_categories;

CREATE PROCEDURE sp_get_categories()
BEGIN
    SELECT category_id, name
        FROM categories;
END;

