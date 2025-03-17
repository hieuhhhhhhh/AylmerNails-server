DROP PROCEDURE IF EXISTS sp_get_colors;

CREATE PROCEDURE sp_get_colors()
BEGIN
    SELECT *
        FROM colors;
END;

