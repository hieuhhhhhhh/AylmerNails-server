import time
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


# rollback and close connection:
def timeout_connection(connection):
    lifetime = 10

    # check every second if the connection is still alive
    for i in range(lifetime):
        # if connection is closed, function end
        time.sleep(1)
        if not connection.is_connected():
            return
        else:
            print("waiting.")

    # If the connection is still alive after 60 seconds, force close
    connection.rollback()
    connection.close()
    print("\nConnection rolled back and closed because time-out.")


def call_3D_proc_with_lock(sp_name, tables, *params):
    print(f"\033[34mCalling: \033[0m{sp_name}")

    # results is a 3D list, so it's called a matrix [table][row][column]
    matrix = []
    connection = None

    try:
        # Connect to the database
        connection = mysql.connector.connect(**DATABASE_CONFIG)
        connection.autocommit = False

        # Set time out so connection will always close
        job_queue.put(lambda: timeout_connection(connection))

        # Use a cursor within a context manager to handle its closing
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

        job_queue.put(lambda: commit_connection(connection))

    except mysql.connector.Error as err:
        job_queue.put(lambda: rollback_connection(connection))
        print(f"Error: {err}")
        raise

    print()
    return matrix  # Return the matrix to the caller
