DROP PROCEDURE IF EXISTS sp_ban_unban_phone_num;

CREATE PROCEDURE sp_ban_unban_phone_num(
    IN _session JSON,
    IN _phone_num VARCHAR(30),
    IN _boolean BOOLEAN
)
BEGIN    
    -- variables
    DECLARE phone_num_id_ INT UNSIGNED;
    DECLARE role_ VARCHAR(50);

    -- validate session token
    CALL sp_validate_admin(_session);    

    -- fetch phone number id
    CALL sp_get_phone_num_id(_phone_num, phone_num_id_);

    -- fetch role of phone number
    SELECT role
        INTO role_
        FROM authentication a
            JOIN phone_numbers p
                ON p.phone_num_id = a.phone_num_id
        WHERE p.value = _phone_num;

    -- validate role
    IF role_ IN ('admin', 'owner')
    THEN 
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = '400, Not allowed to ban admin level accounts';
    END IF;

    -- insert or delete row
    IF _boolean THEN
        INSERT IGNORE INTO blacklist (phone_num_id)    
            VALUES (phone_num_id_);
        
        -- log out everywhere
        DELETE u
            FROM user_sessions u
                JOIN authentication a
                    ON a.user_id = u.user_id
                JOIN phone_numbers p
                    ON p.phone_num_id = a.phone_num_id
            WHERE p.value = _phone_num;

    ELSE
        DELETE FROM blacklist
            WHERE phone_num_id = phone_num_id_;
    END IF;
END;