DROP PROCEDURE IF EXISTS sp_move_cate_up;

CREATE PROCEDURE sp_move_cate_up(
    IN _session JSON,
    IN _1st_id INT UNSIGNED
)
BEGIN
    -- variables
    DECLARE 1st_order_ INT;
    DECLARE 2nd_order_ INT;
    DECLARE 2nd_id_ INT UNSIGNED;

    -- validate session token
    CALL sp_validate_admin(_session);

    -- fetch 1st category order
    SELECT sort_order
        INTO 1st_order_
        FROM categories
        WHERE category_id = _1st_id;

    -- fetch 2nd category order
    SELECT sort_order, category_id
        INTO 2nd_order_, 2nd_id_
        FROM categories
        WHERE sort_order = _1st_id - 1;

    -- swap sort order of those 2
    UPDATE my_table
        SET sort_order = CASE category_id
            WHEN _1st_id THEN 2nd_order_
            WHEN 2nd_id_ THEN 1st_order_
        END
        WHERE category_id IN (_1st_id, 2nd_id_);
END; 

