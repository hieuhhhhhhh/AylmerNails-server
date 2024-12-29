-- show details of an appointment

CREATE TABLE appo_details (
    appo_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    employee_id INT UNSIGNED,
    service_id INT UNSIGNED,
    date BIGINT NOT NULL,
    start_time INT NOT NULL,
    end_time INT NOT NULL,

    -- list of employees that the client accepted for the appointment
    employees_selected VARCHAR(500),

    -- is FALSE when the appointment is created or modified by higher level users (admin)
    created_by_client BOOLEAN NOT NULL DEFAULT TRUE, 

    FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    FOREIGN KEY (service_id) REFERENCES services(service_id) 
);


-- index on employee_id
CREATE INDEX idx_employee_id ON appo_details(employee_id);

-- index on service_id
CREATE INDEX idx_service_id ON appo_details(service_id);

-- index on date -> employee_id -> service_id
CREATE INDEX idx_date_employee_service ON appo_details(date, employee_id, service_id);

-- index on start_time
CREATE INDEX idx_start_time ON appo_details(start_time);

-- index on end_time
CREATE INDEX idx_end_time ON appo_details(end_time);
