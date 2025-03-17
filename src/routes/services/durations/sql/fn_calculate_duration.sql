DROP FUNCTION IF EXISTS fn_calculate_duration;

CREATE FUNCTION fn_calculate_duration(
    _service_id INT UNSIGNED,
    _employee_id INT UNSIGNED,
    _AOSOs JSON  -- list of selected add-on-service options for the selected service
)
RETURNS INT
DETERMINISTIC
BEGIN
    -- index to iterate json array
    DECLARE i INT DEFAULT 0;

    -- other place holders
    DECLARE offset_ INT DEFAULT 0;
    DECLARE AOS_id_ INT UNSIGNED;
    DECLARE option_id_ INT UNSIGNED;

    -- declare return variable
    DECLARE duration_ INT DEFAULT NULL;

    -- fetch personal duration (if there is)
    SELECT duration
        INTO duration_
        FROM durations
        WHERE service_id = _service_id
            AND employee_id = _employee_id;

    -- if not found use default duration
    IF duration_ IS NULL THEN
        SELECT duration
            INTO duration_
            FROM services 
            WHERE service_id = _service_id;
    END IF;

    -- append offsets for AOSOs 
    WHILE i < JSON_LENGTH(_AOSOs) DO 
        -- fetch every AOS_id_
        SET AOS_id_ = JSON_UNQUOTE(JSON_EXTRACT(_AOSOs, CONCAT('$[', i, ']')));
        SET i = i + 1;

        -- fetch the option id for that AOS
        SET option_id_ = JSON_UNQUOTE(JSON_EXTRACT(_AOSOs, CONCAT('$[', i, ']')));
        SET i = i + 1;

        -- fetch and merge offset of that option
        SELECT length_offset
            INTO offset_
            FROM AOS_options ao
                JOIN add_on_services aos
                ON aos.AOS_id = ao.AOS_id
            WHERE aos.service_id = _service_id
                AND ao.AOS_id = AOS_id_
                AND ao.option_id = option_id_
            LIMIT 1;

        SET duration_ = duration_ + IFNULL(offset_, 0);

        -- end loop
    END WHILE;

    -- return the result
    RETURN duration_;

END;

