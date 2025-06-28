DROP PROCEDURE IF EXISTS sp_update_service_info;

CREATE PROCEDURE sp_update_service_info(
    IN _session JSON,
    IN _service_id INT UNSIGNED, 
    IN _name VARCHAR(50),
    IN _service_name_tokens JSON, -- array of tokens of service's name
    IN _description VARCHAR(500),
    IN _category_id INT UNSIGNED,
    IN _last_date BIGINT,
    IN _price DECIMAL(10, 2),
    IN _client_can_book BOOLEAN
)
BEGIN
    -- validate token session
    CALL sp_validate_admin(_session);

    -- Check if the employee exists
    IF NOT EXISTS (SELECT 1 FROM services WHERE service_id = _service_id) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '400, Invalid service_id, no such service exists';
    END IF;

    -- update first 5 properties
    UPDATE services
        SET name = _name,
            description = _description,
            category_id = _category_id,
            price = _price,
            client_can_book = _client_can_book
        WHERE service_id = _service_id;
        
    -- extract and store name tokens
    CALL sp_store_name_tokens(_service_id, _service_name_tokens);

    -- update last_date
    UPDATE services
        SET last_date = _last_date
        WHERE service_id = _service_id;

    -- if last_date updated scan for conflicts
    IF ROW_COUNT() > 0 THEN        
        CALL sp_scan_SLD_conflicts(_service_id);
    END IF;


END;
