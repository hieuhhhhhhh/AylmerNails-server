SELECT
    CASE
        WHEN EXISTS (
            SELECT
                1
            FROM
                INFORMATION_SCHEMA.SCHEMATA
            WHERE
                SCHEMA_NAME = 'test_db'
        ) THEN 1
        ELSE 0
    END;