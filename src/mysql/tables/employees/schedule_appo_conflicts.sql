CREATE TABLE schedule_appo_conflicts(
    schedule_begin BIGINT,
    appo_id INT UNSIGNED,
    FOREIGN KEY (schedule_begin) REFERENCES schedules(schedule_begin)
        ON DELETE CASCADE,
    FOREIGN KEY (appo_id) REFERENCES appo_details(appo_id)
        ON DELETE CASCADE,
    PRIMARY KEY (schedule_begin, appo_id)
);