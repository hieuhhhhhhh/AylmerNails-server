-- DES = on 1 date, on 1 employee, on 1 service

CREATE TABLE DES_availability (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    day_start BIGINT NOT NULL,
    employee_id INT UNSIGNED NOT NULL,
    service_id INT UNSIGNED NOT NULL,

    -- array of all available slots on that day
    available_clock_times JSON -- clock time = time on that date in seconds

    FOREIGN KEY (employee_id) REFERENCES employees(employee_id) 
        ON DELETE CASCADE,
    FOREIGN KEY (service_id) REFERENCES services(service_id) 
        ON DELETE CASCADE

);

-- index for search queries with order: day_start -> employee_id -> service_id
CREATE UNIQUE INDEX idx_day_employee_service 
    ON DES_availability (day_start, employee_id, service_id);
