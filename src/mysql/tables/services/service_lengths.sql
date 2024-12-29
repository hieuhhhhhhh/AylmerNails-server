CREATE TABLE service_lengths(
    service_length_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    service_id INT UNSIGNED NOT NULL,
    effective_from BIGINT NOT NULL, -- the date when it start taking effect
    length INT NOT NULL, -- length of service in seconds
    FOREIGN KEY (service_id) REFERENCES services(service_id)
        ON DELETE CASCADE
);

-- idx on service_id -> effective_from
CREATE INDEX idx_service_id_effective_from 
    ON (service_id, effective_from);
