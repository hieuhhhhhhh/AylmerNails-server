-- DES = on 1 date, on 1 employee, on 1 service

CREATE TABLE DES_availability (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    date BIGINT NOT NULL, -- date in unix time (in seconds)
    employee_id INT UNSIGNED NOT NULL,
    service_id INT UNSIGNED NOT NULL,

    -- array of all available slots on that day
    available_times JSON -- all available clock times on DES

    FOREIGN KEY (employee_id) REFERENCES employees(employee_id) 
        ON DELETE CASCADE,
    FOREIGN KEY (service_id) REFERENCES services(service_id) 
        ON DELETE CASCADE

);

-- index for search queries with order: date -> employee_id -> service_id
CREATE UNIQUE INDEX idx_day_employee_service 
    ON DES_availability (date, employee_id, service_id);
