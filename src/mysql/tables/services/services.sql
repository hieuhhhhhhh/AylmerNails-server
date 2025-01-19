CREATE TABLE services(
    service_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description VARCHAR(500),
    category_id INT UNSIGNED,
    last_date BIGINT,
    
    FOREIGN KEY (category_id) 
        REFERENCES categories(category_id)
);

-- index on last_date
CREATE INDEX idx_last_date ON services(last_date);
