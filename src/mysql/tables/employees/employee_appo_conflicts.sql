CREATE TABLE employee_appo_conflicts(
    employee_id INT UNSIGNED,
    appo_id INT UNSIGNED,

    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
        ON DELETE CASCADE,
    FOREIGN KEY (appo_id) REFERENCES appo_details(appo_id)
        ON DELETE CASCADE,
        
    PRIMARY KEY (employee_id, appo_id)
);