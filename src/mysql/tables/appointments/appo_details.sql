-- show key aspects of an appointment

CREATE TABLE appo_details (
    appo_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    employee_id INT UNSIGNED,
    service_id INT UNSIGNED,
    phone_num_id INT UNSIGNED,
    selected_AOSO JSON, -- list of selected add-on-service options for the selected service
    date BIGINT NOT NULL, -- date in unix time (in seconds)
    day_of_week ENUM('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'), -- start from monday = 1, end at sunday = 7
    start_time INT NOT NULL, -- clock time when the appointment starts on that day (in seconds)
    end_time INT NOT NULL,
    message VARCHAR(500),
    booker_id INT UNSIGNED,
    price DECIMAL(10,2),
    client_can_book BOOLEAN DEFAULT TRUE,

    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
        ON DELETE SET NULL,
    FOREIGN KEY (service_id) REFERENCES services(service_id) 
        ON DELETE SET NULL,
    FOREIGN KEY (phone_num_id) REFERENCES phone_numbers(phone_num_id) 
        ON DELETE SET NULL,
    FOREIGN KEY (booker_id) REFERENCES authentication(user_id) 
        ON DELETE SET NULL
);

-- index on service_id -> date
CREATE INDEX idx_service_id_date ON appo_details(service_id, date);

-- index on employee_id -> date
CREATE INDEX idx_employee_id_date ON appo_details(employee_id, date);

-- index on phone_num_id -> date
CREATE INDEX idx_phone_num_id_date ON appo_details(phone_num_id, date);

-- index on date -> employee_id -> start_time
CREATE INDEX idx_date_employee_id_start_time ON appo_details(date, employee_id, start_time);

-- index on date -> employee_id -> end_time
CREATE INDEX idx_date_employee_id_end_time ON appo_details(date, employee_id, end_time);

-- TRIGGERS to reset DELAs
CREATE TRIGGER after_appos_insert
    AFTER INSERT ON appo_details
    FOR EACH ROW
    BEGIN
        CALL sp_remove_expired_DELAs(NEW.date, NEW.employee_id);
    END;


CREATE TRIGGER after_appos_update
    AFTER UPDATE ON appo_details
    FOR EACH ROW
    BEGIN
        CALL sp_remove_expired_DELAs(NEW.date, NEW.employee_id);
    END;

CREATE TRIGGER after_appos_delete
    AFTER DELETE ON appo_details
    FOR EACH ROW
    BEGIN
        CALL sp_remove_expired_DELAs(OLD.date, OLD.employee_id);
    END;
