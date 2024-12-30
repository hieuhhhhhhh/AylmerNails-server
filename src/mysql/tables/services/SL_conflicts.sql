-- SL = service's length

CREATE TABLE SL_conflicts(
    service_length_id INT UNSIGNED,
    appo_id INT UNSIGNED,

    FOREIGN KEY (service_length_id) REFERENCES service_lengths(service_length_id)
        ON DELETE CASCADE,
    FOREIGN KEY (appo_id) REFERENCES appo_details(appo_id)
        ON DELETE CASCADE,
        
    PRIMARY KEY (service_length_id, appo_id)
);