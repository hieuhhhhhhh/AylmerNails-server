DROP PROCEDURE IF EXISTS sp_get_otp_length;

CREATE PROCEDURE sp_get_otp_length(
    IN _phone_num VARCHAR(30)
)
sp:BEGIN
    -- variables
    DECLARE length_ INT DEFAULT 8;
    DECLARE role_ VARCHAR(30);

    -- fetch role by phone number
    SELECT a.role
        INTO role_
        FROM authentication a
            JOIN phone_numbers p 
                ON a.phone_num_id = p.phone_num_id 
        WHERE p.value = _phone_num;

    -- update length
    IF role_ IN ('client') THEN 
        SET length_ = 6;
    END IF;
    
    IF role_ IS NULL THEN 
        SET length_ = 4;
    END IF;

    -- return otp length
    SELECT length_;
END;