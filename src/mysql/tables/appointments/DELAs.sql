-- DELAs = date, employee, length, availabilities
-- meaning: availability on 1 date, 1 employee, 1 service length

CREATE TABLE DELAs (
    DELA_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    date BIGINT NOT NULL, -- date in unix time (in seconds)
    employee_id INT UNSIGNED NOT NULL,
    planned_length INT NOT NULL,

    FOREIGN KEY (employee_id) REFERENCES employees(employee_id) 
        ON DELETE CASCADE
);

-- index for search queries with order: date -> employee_id -> length
CREATE UNIQUE INDEX idx_date_employee_id_planned_length
    ON DELAs (date, employee_id, planned_length);
