CREATE TABLE services(
    service_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description VARCHAR(500),
    category_id INT UNSIGNED,
    first_date BIGINT NOT NULL,
    last_date BIGINT,
    duration INT NOT NULL,
    client_can_book BOOLEAN DEFAULT TRUE,    
    price DECIMAL(10, 2),
    
    FOREIGN KEY (category_id) 
        REFERENCES categories(category_id)    
);

