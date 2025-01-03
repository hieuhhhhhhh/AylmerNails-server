CREATE TABLE AOS_options (
    option_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    AOS_id INT UNSIGNED NOT NULL,
    name VARCHAR(300),
    length_offset INT NOT NULL,

    FOREIGN KEY (AOS_id) REFERENCES add_on_services(AOS_id)
        ON DELETE CASCADE
);

-- index on AOS_id -> option_id
CREATE INDEX idx_AOS_id_option_id ON AOS_options(AOS_id, option_id)