CREATE TABLE appo_notes(
    appo_id INT UNSIGNED PRIMARY KEY,

    -- note made by admins level upward (not visible to clients)
    note VARCHAR(500),

    FOREIGN KEY (appo_id) REFERENCES appo_details(appo_id)
        ON DELETE CASCADE
);