CREATE TABLE service_length_variations(
    variation_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    service_id INT UNSIGNED NOT NULL,
    employee_id INT UNSIGNED NOT NULL,
    effective_from BIGINT NOT NULL, -- the date when it start taking effect
    length_offset INT NOT NULL, -- offset to original length in seconds
    
    FOREIGN KEY (service_id) REFERENCES services(service_id)
        ON DELETE CASCADE;
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id)
        ON DELETE CASCADE;
);

-- index on service_id -> employee_id -> effective_from
CREATE INDEX idx_service_id_employee_id_effective_from
    ON (service_id, employee_id, effective_from);

