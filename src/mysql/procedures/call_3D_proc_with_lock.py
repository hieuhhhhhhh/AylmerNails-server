import mysql.connector
from src.mysql.db_config import DATABASE_CONFIG
import eventlet


def call_3D_proc_with_lock(sp_name, tables, *params):
    print(f"\033[34mCalling: \033[0m{sp_name}")

    # results is a 3D list, so it's called a matrix [table][row][column]
    matrix = []
    connection = None

    try:
        # Connect to the database
        connection = mysql.connector.connect(**DATABASE_CONFIG)
        connection.autocommit = False

        def work():
            nonlocal matrix
            with connection.cursor() as cursor:
                # lock all necessary tables
                lock_statement = "LOCK TABLES " + ", ".join(
                    [f"{table} WRITE" for table in tables]
                )
                cursor.execute(lock_statement)  # Lock all tables in the list

                # Call the stored procedure with dynamic parameters
                cursor.callproc(sp_name, params)

                # Stack every table returned to matrix
                for table in cursor.stored_results():
                    matrix.append(table.fetchall())  # each table is a 2D list

            connection.commit()

        # Run the DB work with a timeout (60 secs)
        eventlet.with_timeout(60, work)

    except Exception as err:
        connection.rollback()
        print(f"Error: {err}")
        raise

    print()
    return matrix  # Return the matrix to the caller
