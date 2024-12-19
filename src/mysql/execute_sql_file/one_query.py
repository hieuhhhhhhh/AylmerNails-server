# note: execute 1 query, return rows
import os
import mysql.connector
from mysql.connector import Error
from src.mysql.db_config import DATABASE_CONFIG


def exe_one_query(__file__, fileName):
    # get filePath:
    filePath = os.path.join(os.path.dirname(__file__), fileName)

    results = []  # placeholder for table returned from mysql server

    try:
        print(f"Executing: {fileName}")

        # Establishing connection to MySQL server (without specifying database for setup)
        connection = mysql.connector.connect(**DATABASE_CONFIG)

        if connection.is_connected():
            cursor = connection.cursor()

            # Attempt to use default database
            try:
                cursor.execute(f"USE {DATABASE_CONFIG["database"]};")
            except Error:
                pass

            with open(filePath, "r") as file:
                query = file.read().strip()

                cursor.execute(query)  # Execute the query

                # fetch the results
                results = cursor.fetchall()

                # Fetch and print rows involved
                print(f"Rows involved: {cursor.rowcount}")

                # Fetch the last inserted ID for INSERT
                if cursor.lastrowid:
                    print(f"Last inserted ID: {cursor.lastrowid}")

                # Check for warnings
                cursor.execute("SHOW WARNINGS")
                warnings = cursor.fetchall()
                if warnings:
                    print("Warnings:")
                    for warning in warnings:
                        print(f"  - {warning[2]}")

            connection.commit()  # Commit the transaction after executing the queries

    except Error as e:
        print(f"Error: {e}")
        raise

    finally:
        if connection.is_connected():
            cursor.close()
            connection.close()
        print()

    return results  # Return the accumulated results
