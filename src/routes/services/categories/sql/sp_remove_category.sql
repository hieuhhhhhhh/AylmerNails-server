DROP PROCEDURE IF EXISTS sp_remove_category;

CREATE PROCEDURE sp_remove_category(
    IN _session JSON,
    IN _cate_id  INT UNSIGNED
)
BEGIN
    -- variables
    DECLARE user_id_ INT UNSIGNED;
    DECLARE role_ VARCHAR(20);

    -- fetch and validate user's role from session data
    CALL sp_get_user_id_role(_session, user_id_, role_);

    -- IF role is not valid return null and leave procedure
    IF role_ IS NULL
        OR role_ NOT IN ('admin', 'developer')
    THEN 
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = '401, Unauthorized';
    END IF;

    -- delete by category_id
    DELETE FROM categories
        WHERE category_id = _cate_id;
END; 

