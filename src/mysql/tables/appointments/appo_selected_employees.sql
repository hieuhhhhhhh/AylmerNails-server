CREATE TABLE appo_selected_employees(
    appo_id INT UNSIGNED,
    
    -- list of employees that the client accepted for the appointment
    employee_id INT UNSIGNED,

    FOREIGN KEY (appo_id) REFERENCES appo_details(appo_id)
        ON DELETE CASCADE,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
        ON DELETE CASCADE,
    PRIMARY KEY (appo_id, employee_id)
);