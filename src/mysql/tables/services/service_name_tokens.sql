CREATE TABLE service_name_tokens(
    token VARCHAR(50) NOT NULL,
    service_id INT UNSIGNED,

    FOREIGN KEY (service_id) REFERENCES services(service_id)
        ON DELETE CASCADE,
    PRIMARY KEY (token, service_id)
);

CREATE INDEX idx_service_id ON service_name_tokens(service_id);