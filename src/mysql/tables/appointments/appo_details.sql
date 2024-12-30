-- show key aspects of an appointment

CREATE TABLE appo_details (
    appo_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    employee_id INT UNSIGNED,
    service_id INT UNSIGNED,
    date BIGINT NOT NULL, -- date in unix time (in seconds)
    start_time INT NOT NULL, -- clock time when the appointment starts on that day (in seconds)
    end_time INT NOT NULL,

    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
        ON DELETE SET NULL,
    FOREIGN KEY (service_id) REFERENCES services(service_id) 
        ON DELETE SET NULL
);


-- index on employee_id
CREATE INDEX idx_employee_id ON appo_details(employee_id);

-- index on service_id
CREATE INDEX idx_service_id ON appo_details(service_id);

-- index on date -> employee_id
CREATE INDEX idx_date_employee_id ON appo_details(date, employee_id);

-- index on start_time
CREATE INDEX idx_start_time ON appo_details(start_time);

-- index on end_time
CREATE INDEX idx_end_time ON appo_details(end_time);
