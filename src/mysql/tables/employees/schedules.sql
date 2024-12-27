CREATE TABLE schedules(
    schedule_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    employee_id INT UNSIGNED,
    effective_from BIGINT NOT NULL, -- the time when this schedule takes effect
    day_of_the_week TINYINT, -- sunday = 0, monday = 1, tuesday = 2, etc.
    opening_time INT, -- the clock time when employee start on that day (in seconds)
    closing_time INT,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
        ON DELETE CASCADE
);

-- index on employee_id -> day_of_the_week -> effective_from
CREATE INDEX idx_employee_id_day_of_the_week_effective_from ON schedules(employee_id, day_of_the_week, effective_from);
