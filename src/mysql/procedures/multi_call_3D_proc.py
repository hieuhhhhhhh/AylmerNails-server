import mysql.connector
from src.mysql.db_config import DATABASE_CONFIG
import eventlet


def multi_call_3D_proc(sp_name, tables, params_list):
    # print statement
    print(f"\033[34mMultiple-calling: \033[0m{sp_name}")

    # results is a 4D list, so it's called a matrices [call][table][row][column]
    matrices = []

    try:
        # Connect to the database
        connection = mysql.connector.connect(**DATABASE_CONFIG)
        connection.autocommit = False

        def work():
            nonlocal matrices
            # lock all necessary tables
            with connection.cursor() as cursor:
                # lock all necessary tables
                lock_statement = "LOCK TABLES " + ", ".join(
                    [f"{table} WRITE" for table in tables]
                )
                cursor.execute(lock_statement)

            # iterate list of parameters and run procedure
            for params in params_list:
                # Use a cursor within a context manager to handle its closing
                with connection.cursor() as cursor:
                    # Call the stored procedure with parameters
                    cursor.callproc(sp_name, params)

                    # Store result of every call
                    matrix = []
                    for table in cursor.stored_results():
                        matrix.append(table.fetchall())  # each table is a 2D list

                    # add to matrix list
                    matrices.append(matrix)
            connection.commit()

        # Run the DB work with a timeout (60 secs)
        eventlet.with_timeout(60, work)

    except Exception as err:
        connection.rollback()
        print(f"Error: {err}")
        raise

    print()
    return matrices  # Return the matrix to the caller
