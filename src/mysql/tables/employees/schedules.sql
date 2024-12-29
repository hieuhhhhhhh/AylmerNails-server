CREATE TABLE schedules(
    schedule_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    employee_id INT UNSIGNED NOT NULL,
    effective_from BIGINT NOT NULL, -- the date when it start taking effect
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
        ON DELETE CASCADE
);

-- index on employee_id -> effective_from
CREATE INDEX idx_employee_id_effective_from 
    ON (employee_id, effective_from);