import mysql.connector
from src.mysql.db_config import DATABASE_CONFIG
import eventlet


def call_3D_proc(sp_name, *params):
    print(f"\033[34mCalling: \033[0m{sp_name}")

    # results is a 3D list, so it's called a matrix [table][row][column]
    matrix = []
    connection = None

    try:
        connection = mysql.connector.connect(**DATABASE_CONFIG)
        connection.autocommit = False

        def work():
            nonlocal matrix
            with connection.cursor() as cursor:
                cursor.callproc(sp_name, params)
                for table in cursor.stored_results():
                    matrix.append(table.fetchall())
            connection.commit()

        # Run the DB work with a timeout (60 secs)
        eventlet.with_timeout(60, work)

    except Exception as err:
        connection.rollback()
        print(f"Error: {err}")
        raise

    print()
    return matrix  # Return the matrix to the caller
