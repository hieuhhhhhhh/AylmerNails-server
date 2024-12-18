DROP PROCEDURE IF EXISTS sp_process_message;

CREATE PROCEDURE sp_process_message(IN input_message TEXT) BEGIN -- Insert the input message into the hello_table
INSERT INTO
    hello_table (message)
VALUES
    (input_message);

END