CREATE TABLE colors (
    color_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
    name VARCHAR(30) NOT NULL,
    code VARCHAR(30) NOT NULL
);

INSERT INTO colors (name, code) VALUES
('Red', 'rgb(157, 0, 0)'),
('Brown', 'rgb(157, 94, 0)'),
('Green', 'rgb(11, 92, 0)'),
('Mint', 'rgb(1, 140, 150)'),
('Blue', 'rgb(0, 46, 171)'),
('Pink', 'rgb(161, 0, 121)'),
('Purple', 'rgb(58, 0, 157)'),
('Orange', 'rgb(214, 82, 0)'),
('Grass', 'rgb(114, 142, 0)');
