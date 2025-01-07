-- DELA_slots = all available start times on 1 date, 1 employee, 1 service length

CREATE TABLE DELA_slots(
    DELA_id INT UNSIGNED,
    slot INT, -- available start time for an appointment that match that DELA

    FOREIGN KEY (DELA_id) REFERENCES DELA(DELA_id)
        ON DELETE CASCADE,
        
    PRIMARY KEY (DELA_id, slot)
)