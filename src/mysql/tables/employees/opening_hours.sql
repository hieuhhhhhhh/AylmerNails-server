CREATE TABLE opening_hours (
    schedule_begin BIGINT, -- the time when this schedule takes effect
    day_of_the_week TINYINT, -- sunday = 0, monday = 1, tuesday = 2, etc.
    opening_time INT, -- the clock time when employee starts on that day (in seconds)
    closing_time INT, -- the clock time when employee stops on that day (in seconds)
    FOREIGN KEY (schedule_begin) REFERENCES schedules(schedule_begin)
        ON DELETE CASCADE,
    PRIMARY KEY (schedule_begin, day_of_the_week) -- composite primary key
);
