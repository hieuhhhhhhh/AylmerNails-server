# matrix = return multiple tables
# this function to call a proc that return more than 1 table (many SELECT executions)

import mysql.connector
from src.mysql.db_config import DATABASE_CONFIG


def call_3D_proc(sp_name, *params):
    print(f"\033[34mCalling: \033[0m{sp_name}")

    # results is a 3D list so i call it matrix [table][row][column]
    matrix = []
    try:
        # Connect to the database using context manager to handle closing
        with mysql.connector.connect(**DATABASE_CONFIG) as connection:
            with connection.cursor() as cursor:
                # Call the stored procedure with dynamic parameters
                cursor.callproc(sp_name, params)

                # Commit changes if necessary (for UPDATE, DELETE, etc.)
                connection.commit()

                # stack every table returned to matrix
                for table in cursor.stored_results():
                    matrix.append(table.fetchall())  # each table is a 2D list

    except mysql.connector.Error as err:
        print(f"Error: {err}")
        raise

    print()
    return matrix  # Return the matrix to the caller
