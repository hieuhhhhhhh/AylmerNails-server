import mysql.connector
from mysql.connector import Error

def setup_mysql():
    # Database connection details
    host = 'localhost'  
    user = 'root'       
    password = '123Arcus.'  
    database_name = 'test_db'
    table_name = 'hello_table'

    try:
        # Establishing connection
        connection = mysql.connector.connect(
            host=host,
            user=user,
            password=password
        )

        if connection.is_connected():
            cursor = connection.cursor()
            cursor.execute(f"DROP DATABASE IF EXISTS {database_name}")
            cursor.execute(f"CREATE DATABASE {database_name}")
            cursor.execute(f"USE {database_name}")

            # Create table and insert a row
            cursor.execute(f"""
            CREATE TABLE IF NOT EXISTS {table_name} (
                id INT AUTO_INCREMENT PRIMARY KEY,
                message VARCHAR(255)
            )
            """)
            cursor.execute(f"INSERT INTO {table_name} (message) VALUES ('Hello from MySQL')")
            connection.commit()
            print(f"Database and table setup completed.")

    except Error as e:
        print(f"Error: {e}")

    finally:
        if connection.is_connected():
            cursor.close()
            connection.close()
