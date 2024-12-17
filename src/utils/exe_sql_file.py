import mysql.connector
from mysql.connector import Error

def exe_sql_file(filePath):
    # Database connection details
    host = 'localhost'
    user = 'root'
    password = '123Arcus.'

    results = []  # List to store results of SELECT queries

    try:
        # Establishing connection to MySQL server (without specifying database for setup)
        connection = mysql.connector.connect(
            host=host,
            user=user,
            password=password
        )

        if connection.is_connected():
            cursor = connection.cursor()

            with open(filePath, 'r') as file:
                queries = file.read().split(';')

                for query in queries:
                    query = query.strip()
                    if query:  # Skip empty queries
                        cursor.execute(query)  # Execute the query
                        
                        # Fetch and print rows affected
                        print(f"Rows affected: {cursor.rowcount}")
                        
                        # Fetch the last inserted ID for INSERT queries
                        if cursor.lastrowid:
                            print(f"Last inserted ID: {cursor.lastrowid}")

                        # If the query is a SELECT, fetch the results
                        if query.strip().lower().startswith('select'):
                            result = cursor.fetchall()
                            if result:
                                results.append(result)  # Append the result to the list
                            else:
                                print("No rows returned.")
                        
                        # Check for warnings after each query
                        cursor.execute("SHOW WARNINGS")
                        warnings = cursor.fetchall()
                        if warnings:
                            print("Warnings:")
                            for warning in warnings:
                                print(f"  - {warning[2]}")  # Show the warning message (third column)

            connection.commit()  # Commit the transaction after executing the queries

    except Error as e:
        print(f"Error: {e}")
        print(f"Error at: {filePath}")

    finally:
        if connection.is_connected():
            cursor.close()
            connection.close()
    
    return results  # Return the accumulated results
