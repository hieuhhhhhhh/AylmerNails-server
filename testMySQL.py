import mysql.connector
from mysql.connector import Error

def setup_mysql():
    # Database connection details
    host = 'localhost'
    user = 'root'
    password = '123Arcus.'

    try:
        # Establishing connection to MySQL server (without specifying database for setup)
        connection = mysql.connector.connect(
            host=host,
            user=user,
            password=password
        )

        if connection.is_connected():
            cursor = connection.cursor()

            with open('setup.sql', 'r') as file:
                setup_script = file.read()
                queries = setup_script.split(';')

                for query in queries:
                    query = query.strip()
                    if query:  # Skip empty queries
                        cursor.execute(query)                   
                        print(f"Rows affected: {cursor.rowcount}")

            connection.commit()  # Commit the transaction after executing the queries

    except Error as e:
        print(f"Error: {e}")

    finally:
        if connection.is_connected():
            cursor.close()
            connection.close()

if __name__ == '__main__':
    setup_mysql()
