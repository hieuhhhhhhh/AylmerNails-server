CREATE TABLE business_links(
    link_id ENUM('phone_number', 'google_map', 'instagram', 'email') PRIMARY KEY,     
    details JSON
);

-- some default phone numbers
INSERT INTO aylmer_nails.business_links (link_id)
    VALUES
        ('phone_number'),
        ('google_map'),
        ('instagram'),
        ('email');
        
