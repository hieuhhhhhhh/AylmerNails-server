-- SLVs = service length variations (length offsets to specific employees)

CREATE TABLE SLVs(
    service_length_id INT UNSIGNED,
    employee_id INT UNSIGNED,
    length_offset INT NOT NULL, -- offset from original length that is applied to a specific employee (in seconds)
    
    FOREIGN KEY (service_length_id) REFERENCES service_lengths(service_length_id)
        ON DELETE CASCADE,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
        ON DELETE CASCADE,

    PRIMARY KEY (service_length_id, employee_id)
);


