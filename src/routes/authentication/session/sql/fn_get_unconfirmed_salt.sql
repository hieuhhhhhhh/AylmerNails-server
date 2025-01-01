DROP FUNCTION IF EXISTS fn_get_unconfirmed_salt;

CREATE FUNCTION fn_get_unconfirmed_salt(
    _session_id INT UNSIGNED
)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE _session_salt INT DEFAULT NULL;

    SELECT new_salt 
        INTO _session_salt
        FROM unconfirmed_salts
        WHERE session_id = _session_id
        LIMIT 1;

    RETURN _session_salt;
END;
