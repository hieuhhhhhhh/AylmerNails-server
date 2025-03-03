-- show key aspects of an appointment

CREATE TABLE appo_details (
    appo_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    employee_id INT UNSIGNED,
    service_id INT UNSIGNED,
    selected_AOSO JSON, -- list of selected add-on-service options for the selected service
    date BIGINT NOT NULL, -- date in unix time (in seconds)
    start_time INT NOT NULL, -- clock time when the appointment starts on that day (in seconds)
    end_time INT NOT NULL,

    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
        ON DELETE SET NULL,
    FOREIGN KEY (service_id) REFERENCES services(service_id) 
        ON DELETE SET NULL
);

-- index on service_id -> date
CREATE INDEX idx_service_id_date ON appo_details(service_id, date);

-- index on employee_id -> date
CREATE INDEX idx_employee_id_date ON appo_details(employee_id, date);

-- index on date -> employee_id -> start_time
CREATE INDEX idx_date_employee_id_start_time ON appo_details(date, employee_id, start_time);

-- index on date -> employee_id -> end_time
CREATE INDEX idx_date_employee_id_end_time ON appo_details(date, employee_id, end_time);
