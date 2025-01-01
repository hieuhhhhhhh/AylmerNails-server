CREATE TABLE services(
    service_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    category_id INT UNSIGNED NOT NULL,
    last_date BIGINT,
    
    FOREIGN KEY (category_id) 
        REFERENCES service_categories(category_id)
);

-- index on last_date
CREATE INDEX idx_last_date ON services(last_date);

-- index on first_date
CREATE INDEX idx_first_date ON services(first_date);