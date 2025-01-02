CREATE TABLE add_on_services (
    service_id INT UNSIGNED NOT NULL,
    AOS_id INT UNSIGNED AUTO_INCREMENT,
    prompt VARCHAR(400),

    FOREIGN KEY (service_id) REFERENCES services(service_id)
        ON DELETE CASCADE,

    PRIMARY KEY (service_id, AOS_id) -- Composite primary key
);

