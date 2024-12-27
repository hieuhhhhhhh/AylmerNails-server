CREATE TABLE schedules(
    schedule_begin BIGINT PRIMARY KEY,
    employee_id INT UNSIGNED,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
        ON DELETE CASCADE
)