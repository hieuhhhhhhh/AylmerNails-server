DROP PROCEDURE IF EXISTS sp_insert_msg;

CREATE PROCEDURE sp_insert_msg(IN input_message TEXT) BEGIN -- Insert the input message into the hello_table
INSERT INTO
    hello_table (message)
VALUES
    (input_message);

END