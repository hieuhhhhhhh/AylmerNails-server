DROP PROCEDURE IF EXISTS sp_remove_used_DELA;

CREATE PROCEDURE sp_remove_used_DELA(
    IN _DELA_id INT UNSIGNED
)
BEGIN
    -- remove the used DELA (a DELA is for one time use)
    DELETE FROM DELAs
        WHERE DELA_id = _DELA_id;
END;