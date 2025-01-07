-- Revoke INSERT and UPDATE permissions on the appo_details table from the root user
REVOKE INSERT, UPDATE ON appo_details FROM 'root'@'%';

-- Grant EXECUTE permission on the stored procedure to the root user
GRANT EXECUTE ON PROCEDURE sp_add_appo_by_DELA, sp_add_appo_manually TO 'root'@'%';

-- Grant SELECT (read) and DELETE permissions on appo_details table to the root user
GRANT SELECT, DELETE ON appo_details TO 'root'@'%';

FLUSH PRIVILEGES;