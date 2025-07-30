DROP PROCEDURE IF EXISTS sp_move_cate_up;

CREATE PROCEDURE sp_move_cate_up(
    IN _session JSON,
    IN _1st_id INT UNSIGNED
)
BEGIN
    -- variables
    DECLARE 1st_order_ INT;

    -- validate session token
    CALL sp_validate_admin(_session);

    -- fetch 1st category order
    SELECT sort_order
        INTO 1st_order_
        FROM categories
        WHERE category_id = _1st_id;

    -- swap sort order of those 2
    UPDATE categories
        SET sort_order = NULL
        WHERE category_id = _1st_id;

    UPDATE categories
        SET sort_order = 1st_order_
        WHERE sort_order = 1st_order_ - 1;

    UPDATE categories
        SET sort_order = 1st_order_ - 1
        WHERE category_id = _1st_id;
END; 

