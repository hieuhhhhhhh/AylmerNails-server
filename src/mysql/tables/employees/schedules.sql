CREATE TABLE schedules(
    schedule_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    employee_id INT UNSIGNED,
    effective_from BIGINT NOT NULL,
    day_of_the_week TINYINT, -- start from sunday = 0, monday = 1, tuesday = 2, ...
    start_time INT,
    end_time INT,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
        ON DELETE CASCADE
);

-- index on employee_id -> start_time
CREATE INDEX idx_employee_start ON schedules(employee_id, start_time);

