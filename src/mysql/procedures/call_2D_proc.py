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


def call_2D_proc(sp_name, *params):
    print(f"\033[34mCalling: \033[0m{sp_name}")

    # results are a 2D list [row][column]
    results = []
    connection = None
    try:
        # Connect to the database
        connection = mysql.connector.connect(**DATABASE_CONFIG)
        connection.autocommit = False

        # Use a cursor within a context manager to handle its closing
        with connection.cursor() as cursor:
            # Call the stored procedure with dynamic parameters
            cursor.callproc(sp_name, params)

            # Merge all tables into one single list of results
            for table in cursor.stored_results():
                results.extend(table.fetchall())

        job_queue.put(lambda: commit_connection(connection))

    except mysql.connector.Error as err:
        job_queue.put(lambda: rollback_connection(connection))
        print(f"Error: {err}")
        raise

    print()
    return results  # Return the results to the caller
