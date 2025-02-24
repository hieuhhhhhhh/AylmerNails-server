CREATE TABLE colors (
    color_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
    name VARCHAR(30) NOT NULL,
    code VARCHAR(30) NOT NULL
);

INSERT INTO colors (name, code) VALUES
('Red', 'rgb(234, 89, 89)'),
('Brown', 'rgb(200, 146, 66)'),
('Green', 'rgb(133, 255, 117)'),
('Mint', 'rgb(94, 244, 255)'),
('Blue', 'rgb(108, 147, 255)'),
('Pink', 'rgb(254, 162, 231)'),
('Purple', 'rgb(183, 143, 252)'),
('Orange', 'rgb(255, 159, 99)'),
('Grass', 'rgb(209, 255, 27)');
