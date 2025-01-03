CREATE TABLE service_length_conflicts(
    service_length_id INT UNSIGNED,
    appo_id INT UNSIGNED,

    FOREIGN KEY (service_length_id) REFERENCES service_lengths(service_length_id)
        ON DELETE CASCADE,
    FOREIGN KEY (appo_id) REFERENCES appo_details(appo_id)
        ON DELETE CASCADE,
        
    PRIMARY KEY (service_length_id, appo_id)
);

-- index on appo_id
CREATE INDEX idx_appo_id ON service_length_conflicts(appo_id);