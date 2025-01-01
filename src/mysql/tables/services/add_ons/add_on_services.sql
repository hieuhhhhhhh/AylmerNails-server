CREATE TABLE add_on_services(
    AOS_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    service_id INT UNSIGNED NOT NULL,
    prompt VARCHAR(400), 

    FOREIGN KEY (service_id) REFERENCES services(service_id)
        ON DELETE CASCADE
);

-- index on service_id
CREATE INDEX idx_service_id ON add_on_services(service_id);