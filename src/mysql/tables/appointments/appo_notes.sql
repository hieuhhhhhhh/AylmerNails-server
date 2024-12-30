CREATE TABLE appo_notes(
    appo_id INT UNSIGNED PRIMARY KEY,

    -- list of employees that the client accepted for the appointment
    employees_selected VARCHAR(500),

    -- note made by admins (not visible to clients)
    note VARCHAR(500),


    FOREIGN KEY (appo_id) REFERENCES appo_details(appo_id)
        ON DELETE CASCADE,
)