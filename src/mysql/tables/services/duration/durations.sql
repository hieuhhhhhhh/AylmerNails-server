 -- service duration for some employees

CREATE TABLE durations(
    service_id INT UNSIGNED,
    employee_id INT UNSIGNED,
    duration INT NOT NULL,

    FOREIGN KEY (service_id) REFERENCES services(service_id)
        ON DELETE CASCADE,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
        ON DELETE CASCADE,

    -- composite primary key
    PRIMARY KEY (service_id, employee_id)
);
