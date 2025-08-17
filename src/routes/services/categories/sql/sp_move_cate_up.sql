DROP PROCEDURE IF EXISTS sp_move_cate_up;

CREATE PROCEDURE sp_move_cate_up(
    IN _session JSON,
    IN first_id INT UNSIGNED
)
BEGIN
    -- variables
    DECLARE first_order INT;
    DECLARE second_id INT;
    DECLARE second_order INT;

    -- validate session token
    CALL sp_validate_admin(_session);

    -- fetch the current category's sort_order
    SELECT sort_order
        INTO first_order
        FROM categories
        WHERE category_id = first_id;

    -- fetch the category directly above (with the next lower sort_order)
    SELECT category_id, sort_order
        INTO second_id, second_order
        FROM categories
        WHERE sort_order < first_order
        ORDER BY sort_order DESC
        LIMIT 1;

    -- only proceed if there's a category above to swap with
    IF second_id IS NOT NULL THEN
        -- swap orders using a temporary value
        UPDATE categories
            SET sort_order = -1
            WHERE category_id = first_id;

        UPDATE categories
            SET sort_order = first_order
            WHERE category_id = second_id;

        UPDATE categories
            SET sort_order = second_order
            WHERE category_id = first_id;
    END IF;
END;
