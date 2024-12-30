import mysql.connector
from src.mysql.db_config import DATABASE_CONFIG
from .thread_pool import job_queue


# This method will close the connection in a separate thread
def close_connection(connection):
    if connection:
        connection.close()  # Closing the connection (blocking, but not awaited in main flow)


def call_2D_proc(sp_name, *params):
    print(f"\033[34mCalling: \033[0m{sp_name}")

    # results are a 2D list [row][column]
    results = []
    connection = None
    try:
        # Connect to the database
        connection = mysql.connector.connect(**DATABASE_CONFIG)
        connection.autocommit = True

        # Use a cursor within a context manager to handle its closing
        with connection.cursor() as cursor:
            # Call the stored procedure with dynamic parameters
            cursor.callproc(sp_name, params)

            # Merge all tables into one single list of results
            for table in cursor.stored_results():
                results.extend(table.fetchall())

    except mysql.connector.Error as err:
        print(f"Error: {err}")
        raise

    finally:
        # send job to thread pool
        job_queue.put(lambda: close_connection(connection))

    print()
    return results  # Return the results to the caller
