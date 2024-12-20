# note: execute many queries sequentially, no log-prints, no return
import os
import mysql.connector
from mysql.connector import Error
from src.mysql.db_config import DATABASE_CONFIG as CONFIG


def exe_queries(__file__, fileName):
    # get filePath:
    filePath = os.path.join(os.path.dirname(__file__), fileName)

    try:
        print(f"Executing: {fileName}")

        # Establishing connection to MySQL server (without specifying database for setup)
        connection = mysql.connector.connect(
            host=CONFIG["host"], user=CONFIG["user"], password=CONFIG["password"]
        )
        if connection.is_connected():
            cursor = connection.cursor()

            # Attempt to use the specified database
            try:
                cursor.execute(f"USE {CONFIG["database"]};")
            except Error:
                pass

            # Read all queries from the file
            with open(filePath, "r") as file:
                queries = file.read()

            # Execute the entire block of queries at once
            try:
                for result in cursor.execute(queries, multi=True):
                    pass
            except Error as e:
                raise

            connection.commit()  # Commit the transaction after executing all queries

    except Error as e:
        print(f"Error: {e}")
        raise

    finally:
        if connection.is_connected():
            cursor.close()
            connection.close()
        print()
