CREATE TABLE schedules(
    schedule_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    employee_id INT UNSIGNED,
    start_time BIGINT NOT NULL,
    sun_start INT,
    sun_end INT,
    mon_start INT,
    mon_end INT,    
    tue_start INT,
    tue_end INT,    
    wed_start INT,
    wed_end INT,    
    thu_start INT,
    thu_end INT,    
    fri_start INT,
    fri_end INT,    
    sar_start INT,
    sar_end INT,    
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
        ON DELETE CASCADE
);

-- index on employee_id -> start_time
CREATE INDEX idx_employee_start ON schedules(employee_id, start_time);

