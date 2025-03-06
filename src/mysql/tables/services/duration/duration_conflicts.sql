CREATE TABLE duration_conflicts(
    service_id INT UNSIGNED,
    appo_id INT UNSIGNED,

    FOREIGN KEY (service_id) REFERENCES services(service_id)
        ON DELETE CASCADE,
    FOREIGN KEY (appo_id) REFERENCES appo_details(appo_id)
        ON DELETE CASCADE,
        
    PRIMARY KEY (service_id, appo_id)
);

-- index on appo_id
CREATE INDEX idx_appo_id ON duration_conflicts(appo_id);