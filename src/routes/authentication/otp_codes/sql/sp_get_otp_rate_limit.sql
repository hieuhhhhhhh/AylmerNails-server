DROP PROCEDURE IF EXISTS sp_get_otp_rate_limit;

CREATE PROCEDURE sp_get_otp_rate_limit(
    IN _raw_ip VARCHAR(300)
)
sp:BEGIN
    -- variables
    DECLARE ip_address_ VARBINARY(16);
    DECLARE wait_until_ BIGINT;
    DECLARE next_wait_until_ BIGINT;
    DECLARE wait_score_ INT;
    DECLARE now_ BIGINT;

    -- fetch unix time of now
    SET now_ = UNIX_TIMESTAMP();

    -- remove 1 week old records
    DELETE FROM otp_rate_limits
        WHERE created_at < now_ - 7*24*60*60;

    -- parse ip address to binary
    SET ip_address_ = INET6_ATON(_raw_ip);

    -- fetch wait until
    SELECT wait_until, wait_score
        INTO wait_until_, wait_score_
        FROM otp_rate_limits
        WHERE ip_address = ip_address_;

    -- if data not found, preset variables
    IF wait_until_ IS NULL THEN
        SET wait_until_ = now_;
        SET next_wait_until_ = now_;
        SET wait_score_ = 0;
    END IF;

    -- if the wait is done
    IF wait_until_ <= now_ THEN
        -- increase score
        SET wait_score_ = wait_score_ + 2;

        -- calculate next wait until
        SET next_wait_until_ = now_ + POW(2, wait_score_) + 16;

        -- overwrite wait value
        INSERT INTO otp_rate_limits(ip_address, wait_until, wait_score)
            VALUES (ip_address_, next_wait_until_, wait_score_)
            ON DUPLICATE KEY UPDATE
                wait_until = next_wait_until_,
                wait_score = wait_score_;
    END IF;

    -- return wait values
    SELECT wait_until_, next_wait_until_, now_;
END;