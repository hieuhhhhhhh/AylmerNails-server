DROP PROCEDURE IF EXISTS sp_update_service_info;

CREATE PROCEDURE sp_update_service_info(
    IN _session JSON,
    IN _service_id INT UNSIGNED, 
    IN _name VARCHAR(50),
    IN _description VARCHAR(500),
    IN _category_id INT UNSIGNED,
    IN _last_date BIGINT
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

    -- Check if the employee exists
    IF NOT EXISTS (SELECT 1 FROM services WHERE service_id = _service_id) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '400, Invalid service_id, no such service exists';
    END IF;

    -- update first 3 properties
    UPDATE services
        SET name = _name,
            description = _description,
            category_id = _category_id
        WHERE service_id = _service_id;

    -- pre-check if last date is really new before update it
    IF NOT EXISTS(
        SELECT 1 FROM services 
            WHERE service_id = _service_id 
                AND last_date = _last_date
    )THEN
        UPDATE services
            SET last_date = _last_date
            WHERE service_id = _service_id;

        -- Call sp_scan_SLD_conflicts to find any appointments that conflict the update
        CALL sp_scan_SLD_conflicts(_service_id);
    END IF;

END;
