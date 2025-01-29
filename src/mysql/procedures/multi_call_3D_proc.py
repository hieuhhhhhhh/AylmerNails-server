import mysql.connector
from src.mysql.db_config import DATABASE_CONFIG
from .thread_pool import job_queue


# commit and close connection:
def commit_connection(connection):
    if connection:
        connection.commit()
        connection.close()  # Closing the connection


# rollback and close connection:
def rollback_connection(connection):
    if connection:
        connection.rollback()
        connection.close()


def call_3D_proc(sp_name, *params_list):
    # print statement
    print(f"\033[34mMultiple-calling: \033[0m{sp_name}")

    # results is a 4D list, so it's called a matrices [call][table][row][column]
    matrices = []

    try:
        # Connect to the database
        connection = mysql.connector.connect(**DATABASE_CONFIG)
        connection.autocommit = False

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

        job_queue.put(lambda: commit_connection(connection))

    except mysql.connector.Error as err:
        job_queue.put(lambda: rollback_connection(connection))
        print(f"Error: {err}")
        raise

    print()
    return matrices  # Return the matrix to the caller
