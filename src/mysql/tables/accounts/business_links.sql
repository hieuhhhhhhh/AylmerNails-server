CREATE TABLE business_links(
    link_id INT UNSIGNED PRIMARY KEY,
    name VARCHAR(300),
    value VARCHAR(500)
)

-- some default phone numbers
INSERT INTO aylmer_nails.business_links (link_id)
    VALUES
        (1),
        (2),
        (3),
        (4),
        (5);
        
