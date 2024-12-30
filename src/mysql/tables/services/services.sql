CREATE TABLE services(
    service_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    category_id INT UNSIGNED NOT NULL,
    final_date BIGINT,
    
    FOREIGN KEY (category_id) 
        REFERENCES service_categories(category_id)
);

-- index on final_date
CREATE INDEX idx_final_date ON services(final_date);