-- DEL_available_times = all available start times on 1 date, 1 employee, 1 service length

CREATE TABLE DEL_available_times(
    DELA_id INT UNSIGNED,
    start_time INT, -- available start time for an appointment that match that DELA

    PRIMARY KEY (DELA_id, start_time)
)