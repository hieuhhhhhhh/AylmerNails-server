CREATE TABLE employees(
    employee_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    alias VARCHAR(50) NOT NULL,
    first_date BIGINT UNSIGNED NOT NULL, -- the first day that this employee start working for the business
    last_date BIGINT UNSIGNED
);

CREATE INDEX idx_first_date ON employees(first_date);
CREATE INDEX idx_last_date ON employees(last_date);