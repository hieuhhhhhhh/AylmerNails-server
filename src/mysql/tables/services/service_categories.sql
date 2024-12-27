CREATE TABLE service_categories(
    category_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    group_id INT UNSIGNED,
    FOREIGN KEY (group_id)
        REFERENCES category_groups(group_id)
)