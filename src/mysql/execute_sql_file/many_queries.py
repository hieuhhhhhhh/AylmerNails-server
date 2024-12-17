# note: execute many queries sequentially, no log-prints, no return
import os
import mysql.connector
from mysql.connector import Error


def exe_queries(__file__, fileName):
    # get filePath:
    filePath = os.path.join(os.path.dirname(__file__), fileName)
    # Database connection details
    host = "localhost"
    user = "root"
    password = "123Arcus."
    database = "test_db"

    try:
        print(f"\033[94mExecuting SQL: \033[0m{filePath}")

        # Establishing connection to MySQL server (without specifying database for setup)
        connection = mysql.connector.connect(host=host, user=user, password=password)

        if connection.is_connected():
            cursor = connection.cursor()

            # Attempt to use the specified database
            try:
                cursor.execute(f"USE {database};")
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
                print(f"Error: {e}")

            connection.commit()  # Commit the transaction after executing all queries

    except Error as e:
        print(f"Error: {e}")

    finally:
        if connection.is_connected():
            cursor.close()
            connection.close()
        print()
