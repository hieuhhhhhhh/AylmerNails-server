CREATE TABLE business_links(
    link_id ENUM('phone_number', 'google_map', 'instagram', 'email') PRIMARY KEY,     
    details JSON
);

-- some default phone numbers
INSERT INTO aylmer_nails.business_links (link_id,details) 
    VALUES
        ('phone_number','{"value": "519 851 7338", "visible": true}'),
        ('google_map','{"url": "https://maps.app.goo.gl/EBT4k8wMvygQFVxN9", "value": "24 Talbot St W, Aylmer, ON N5H 2C2", "visible": true}'),
        ('instagram','{"url": "https://www.instagram.com/aylmer_nails?utm_source=ig_web_button_share_sheet&igsh=ZDNlZDc0MzIxNw==", "value": "@aylmer_nails", "visible": true}'),
        ('email','{"value": "email@gmail.com", "visible": true}');

