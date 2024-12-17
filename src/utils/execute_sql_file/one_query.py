import mysql.connector
from mysql.connector import Error


def exe_one_query(filePath):
    # Database connection details
    host = "localhost"
    user = "root"
    password = "123Arcus."
    database = "test_db"
    results = []  # List to store results of SELECT queries

    try:
        # Establishing connection to MySQL server (without specifying database for setup)
        connection = mysql.connector.connect(host=host, user=user, password=password)

        if connection.is_connected():
            cursor = connection.cursor()

            # Attempt to use default database
            try:
                cursor.execute(f"USE {database};")
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

    finally:
        if connection.is_connected():
            cursor.close()
            connection.close()

    return results  # Return the accumulated results
