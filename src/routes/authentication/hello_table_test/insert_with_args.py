import mysql.connector
from src.mysql.execute_sql_file.many_queries import exe_queries


# build the procedure:
def create_sp_insert_msg():
    print("\033[94m" + "create_sp_insert_msg" + "\033[0m")
    exe_queries(__file__, "sp_insert_msg.sql")


# Database connection configuration
DB_CONFIG = {
    "host": "localhost",  # Change as needed
    "user": "root",  # Change as needed
    "password": "123Arcus.",  # Change as needed
    "database": "test_db",
}


def insert_message_to_db(message):
    print("\033[94m" + "insert_message_to_db" + "\033[0m")
    try:
        # Connect to the database
        connection = mysql.connector.connect(**DB_CONFIG)
        cursor = connection.cursor()

        # Call the stored procedure
        cursor.callproc("sp_process_message", [message])

        # Commit changes
        connection.commit()

    except mysql.connector.Error:
        raise
    finally:
        # Cleanup
        if connection.is_connected():
            cursor.close()
            connection.close()
