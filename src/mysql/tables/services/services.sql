CREATE TABLE services(
    service_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    length INT NOT NULL, -- length of service in seconds
    category_id INT UNSIGNED NOT NULL,
    FOREIGN KEY (category_id) 
        REFERENCES service_categories(category_id)
);