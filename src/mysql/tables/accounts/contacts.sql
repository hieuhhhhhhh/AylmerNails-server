CREATE TABLE contacts (
    phone_num_id INT UNSIGNED PRIMARY KEY,
    name VARCHAR(200) NOT NULL,
    time BIGINT NOT NULL DEFAULT (UNIX_TIMESTAMP()), -- time of the most recent appointment         
    FOREIGN KEY (phone_num_id)
        REFERENCES phone_numbers(phone_num_id)        
);

-- index on time
CREATE INDEX idx_time ON contacts (time);


-- TRIGGERS
CREATE TRIGGER after_contacts_insert
    AFTER INSERT ON contacts
    FOR EACH ROW
    BEGIN
        CALL sp_update_name_tokens(NEW.phone_num_id);
    END;


CREATE TRIGGER after_contacts_update
    AFTER UPDATE ON contacts
    FOR EACH ROW
    BEGIN
        CALL sp_update_name_tokens(NEW.phone_num_id);
    END;


