# note: execute many queries sequentially, only log-prints, no return

# IMPORTANT: this function splits file to many queries using ;
# => DO NOT USE with any query that the ; is not placed at the end

import os
import mysql.connector
from mysql.connector import Error
from src.mysql.db_config import DATABASE_CONFIG


def exe_queries(__file__, fileName):
    # get filePath:
    filePath = os.path.join(os.path.dirname(__file__), fileName)

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
                queries = file.read().split(";")

                for query in queries:
                    query = query.strip()
                    if query:  # Skip empty queries
                        try:
                            cursor.execute(query)  # Execute the query

                            # Fetch and print rows affected
                            print(f"Rows involved: {cursor.rowcount}")

                            # Fetch the last inserted ID for INSERT queries
                            if cursor.lastrowid:
                                print(f"Last inserted ID: {cursor.lastrowid}")

                            # Check for warnings after each query
                            cursor.execute("SHOW WARNINGS")
                            warnings = cursor.fetchall()
                            if warnings:
                                print("Warnings:")
                                for warning in warnings:
                                    print(f"  - {warning[2]}")

                        except Error as e:
                            print(f"Error: {e}")

            connection.commit()  # Commit the transaction after executing the queries

    except Error as e:
        print(f"Error: {e}")
        raise

    finally:
        if connection.is_connected():
            cursor.close()
            connection.close()
        print()
