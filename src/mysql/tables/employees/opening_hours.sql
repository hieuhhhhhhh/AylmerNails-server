CREATE TABLE opening_hours (
    schedule_id INT UNSIGNED, -- the time when this schedule takes effect
    day_of_week TINYINT, -- sunday = 0, monday = 1, tuesday = 2, etc.
    opening_time INT, -- the clock time when employee starts on that day (in seconds)
    closing_time INT, -- the clock time when employee stops on that day (in seconds)
    
    FOREIGN KEY (schedule_id) REFERENCES schedules(schedule_id)
        ON DELETE CASCADE,
    
    PRIMARY KEY (schedule_id, day_of_week) -- composite primary key
);

-- index on opening_time
CREATE INDEX idx_opening_time ON opening_hours(opening_time);

-- index on closing_time
CREATE INDEX idx_closing_time ON opening_hours(closing_time);