-- AOS = add-on service

CREATE TABLE AOS_options(
    option_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(300),
    AOS_id INT UNSIGNED NOT NULL,
    length_offset INT UNSIGNED NOT NULL,

    FOREIGN KEY (AOS_id) REFERENCES add_on_services(AOS_id)
        ON DELETE CASCADE
);

-- index on AOS_id
CREATE INDEX idx_AOS_id ON AOS_options(AOS_id);