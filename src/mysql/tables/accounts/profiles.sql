CREATE TABLE profiles (
    user_id INT UNSIGNED PRIMARY KEY,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    notes VARCHAR(300),
    
    FOREIGN KEY (user_id) 
        REFERENCES authentication(user_id) 
        ON DELETE CASCADE
);

-- index on first and last name
CREATE INDEX idx_first_name ON contacts (first_name);
CREATE INDEX idx_last_name ON contacts (last_name);


-- some default phone numbers
INSERT INTO aylmer_nails.profiles (user_id, first_name, last_name)
    VALUES
        (1,'Henry', 'Duong');
        

