CREATE TABLE employees(
    employee_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    alias VARCHAR(50) NOT NULL,
    stored_intervals JSON,
    interval_percent SMALLINT NOT NULL CHECK (interval_percent BETWEEN 0 AND 100),  

    -- the last day that this employee has appointments
    last_date BIGINT 
);

CREATE INDEX idx_last_date ON employees(last_date);