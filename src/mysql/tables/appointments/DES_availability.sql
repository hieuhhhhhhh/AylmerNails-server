-- DES = on 1 date, on 1 employee, on 1 service

CREATE TABLE DES_availability (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    day_start BIGINT NOT NULL,
    employee_id INT UNSIGNED NOT NULL,
    service_id INT UNSIGNED NOT NULL,
    available_times JSON -- array of all available slots on that day
);

CREATE UNIQUE INDEX idx_day_employee_service 
    ON DES_availability (day_start, employee_id, service_id);
