CREATE TABLE employees_services (
    employee_id INT UNSIGNED,
    service_id INT UNSIGNED,
    FOREIGN KEY (employee_id) REFERENCES employee(employee_id)
        ON DELETE CASCADE,
    FOREIGN KEY (service_id) REFERENCES service(service_id)
        ON DELETE CASCADE,
    PRIMARY KEY (employee_id, service_id)
);
