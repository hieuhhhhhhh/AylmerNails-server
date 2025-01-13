CREATE TABLE employee_services (
    employee_id INT UNSIGNED,
    service_id INT UNSIGNED,
    
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
        ON DELETE CASCADE,
    FOREIGN KEY (service_id) REFERENCES services(service_id)
        ON DELETE CASCADE,

    PRIMARY KEY (employee_id, service_id)
);
