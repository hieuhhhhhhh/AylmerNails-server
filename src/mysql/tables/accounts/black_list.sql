CREATE TABLE black_list(
    phone_num_id INT UNSIGNED PRIMARY KEY,
    created_at BIGINT DEFAULT UNIX_TIMESTAMP()
)