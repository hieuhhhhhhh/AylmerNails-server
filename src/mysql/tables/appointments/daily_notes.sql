CREATE TABLE daily_notes(
    date BIGINT PRIMARY KEY,
    -- note made by admins level upward (not visible to clients)
    note VARCHAR(500)
);