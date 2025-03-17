CREATE TABLE colors (
    color_id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY, 
    name VARCHAR(30) NOT NULL,
    code VARCHAR(30) NOT NULL
);

INSERT INTO colors (name, code) VALUES
('Red', 'rgb(255, 130, 130)'),
('Brown', 'rgb(200, 146, 66)'),
('Green', 'rgb(165, 248, 154)'),
('Mint', 'rgb(145, 243, 250)'),
('Blue', 'rgb(108, 169, 255)'),
('Pink', 'rgb(250, 175, 231)'),
('Purple', 'rgb(183, 143, 252)'),
('Orange', 'rgb(255, 159, 99)'),
('Yellow', 'rgb(253, 241, 106)'),
('Grass', 'rgb(221, 253, 94)');
