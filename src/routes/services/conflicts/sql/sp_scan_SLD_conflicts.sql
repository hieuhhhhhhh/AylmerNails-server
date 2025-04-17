-- ELD = service's last date
-- this proc find conflicts: any apointments that are hold after the last_date of a service

DROP PROCEDURE IF EXISTS sp_scan_SLD_conflicts;

CREATE PROCEDURE sp_scan_SLD_conflicts(
    IN _service_id INT UNSIGNED
)
BEGIN
    DECLARE last_date_ BIGINT;
    DECLARE yesterday_ BIGINT DEFAULT UNIX_TIMESTAMP() - 24*60*60;

    -- fetch last_date
    SELECT last_date
        INTO last_date_
        FROM services
        WHERE service_id = _service_id
        LIMIT 1;

    -- remove old conflicts
    DELETE FROM SLD_conflicts
        WHERE service_id = _service_id;

    -- insert new conflicts
    INSERT INTO SLD_conflicts (appo_id, service_id)
        SELECT appo_id, _service_id
            FROM appo_details
            WHERE service_id = _service_id
                AND date > yesterday_
                AND date > last_date_;

END;
