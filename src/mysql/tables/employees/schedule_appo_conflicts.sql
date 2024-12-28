CREATE TABLE schedule_appo_conflicts(
    schedule_id INT UNSIGNED,
    appo_id INT UNSIGNED,
    FOREIGN KEY (schedule_id) REFERENCES schedules(schedule_id)
        ON DELETE CASCADE,
    FOREIGN KEY (appo_id) REFERENCES appo_details(appo_id)
        ON DELETE CASCADE,
    PRIMARY KEY (schedule_id, appo_id)
);