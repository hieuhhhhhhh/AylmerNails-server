CREATE TABLE AOS_options (
    AOS_id INT UNSIGNED NOT NULL,
    option_id INT UNSIGNED AUTO_INCREMENT,
    name VARCHAR(300),
    length_offset INT NOT NULL,

    FOREIGN KEY (AOS_id) REFERENCES add_on_services(AOS_id)
        ON DELETE CASCADE,

    PRIMARY KEY (AOS_id, option_id)  -- Composite primary key
);
