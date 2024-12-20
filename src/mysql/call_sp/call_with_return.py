import mysql.connector
from src.mysql.db_config import DATABASE_CONFIG


def call_sp(sp_name, OUT_count, *params):
    print(f"Calling procedure: {sp_name}")
    try:
        # placeholder for results:
        results = []

        # Connect to the database
        connection = mysql.connector.connect(**DATABASE_CONFIG)
        cursor = connection.cursor()

        # Call the stored procedure with dynamic parameters
        cursor.callproc(sp_name, params)

        # Commit changes (if necessary)
        connection.commit()

        # Fetch the results (if the stored procedure returns data)
        for result in cursor.stored_results():
            print(result.fetchall())

    except mysql.connector.Error as err:
        print(f"Error: {err}")
        raise
    finally:
        # Cleanup
        if connection.is_connected():
            cursor.close()
            connection.close()
        print()
