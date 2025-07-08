CREATE TABLE phone_numbers (
    phone_num_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    value VARCHAR(30) UNIQUE NOT NULL
);

-- unique index on value
CREATE INDEX idx_phone_num ON phone_numbers (value);

-- TRIGGERS
CREATE TRIGGER after_phone_nums_insert
    AFTER INSERT ON phone_numbers
    FOR EACH ROW
    BEGIN
        CALL sp_add_phone_num_tokens(NEW.phone_num_id, NEW.value);
    END;


CREATE TRIGGER after_phone_nums_update
    AFTER UPDATE ON phone_numbers
    FOR EACH ROW
    BEGIN
        DELETE FROM phone_num_tokens
            WHERE phone_num_id = OLD.phone_num_id;
            
        CALL sp_add_phone_num_tokens(NEW.phone_num_id, NEW.value);
    END;

