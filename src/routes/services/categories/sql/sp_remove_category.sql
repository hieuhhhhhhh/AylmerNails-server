DROP PROCEDURE IF EXISTS sp_remove_category;

CREATE PROCEDURE sp_remove_category(
    IN _session JSON,
    IN _cate_id  INT UNSIGNED
)
BEGIN
    -- validate session token
    CALL sp_validate_admin(_session);

    -- delete by category_id
    DELETE FROM categories
        WHERE category_id = _cate_id;
END; 

