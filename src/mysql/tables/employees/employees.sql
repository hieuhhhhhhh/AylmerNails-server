CREATE TABLE employees(
    employee_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    alias VARCHAR(50) NOT NULL,
    color_id INT UNSIGNED NOT NULL,
    stored_intervals JSON,
    interval_percent SMALLINT NOT NULL CHECK (interval_percent BETWEEN 0 AND 100),  
    created_at BIGINT DEFAULT (UNIX_TIMESTAMP()), 

    -- the last day that this employee has appointments
    last_date BIGINT, 

    
    FOREIGN KEY (color_id) 
        REFERENCES colors(color_id)
);

-- index on last date
CREATE INDEX idx_last_date ON employees(last_date);

-- index on created time
CREATE INDEX idx_created_at ON employees(created_at);