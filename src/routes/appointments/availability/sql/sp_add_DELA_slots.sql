DROP PROCEDURE IF EXISTS sp_add_DELA_slots;

CREATE PROCEDURE sp_add_DELA_slots(
    IN _DELA_id INT UNSIGNED,
    IN _slots JSON
)
BEGIN
    -- placeholders
    DECLARE i TINYINT DEFAULT 0;
    DECLARE slot_ INT;

    -- iterate every slot from a json array
    WHILE i < JSON_LENGTH(_slots) DO
        -- fetch employee_id
        SET slot_ = JSON_UNQUOTE(JSON_EXTRACT(_slots, CONCAT('$[', i, ']')));
        SET i = i + 1;

        -- create new DELA_slot
        INSERT INTO DELA_slots(DELA_id, slot)
            VALUES (_DELA_id, slot_)

        -- end body
    END WHILE;

END;