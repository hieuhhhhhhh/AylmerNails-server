import mysql.connector
from src.mysql.db_config import DATABASE_CONFIG


def call_2D_proc(sp_name, *params):
    print(f"\033[34mCalling: \033[0m{sp_name}")

    # results are a 2D list [row][column]
    results = []
    try:
        # Connect to the database using context manager to handle closing
        with mysql.connector.connect(**DATABASE_CONFIG) as connection:
            with connection.cursor() as cursor:
                # Call the stored procedure with dynamic parameters
                cursor.callproc(sp_name, params)

                # Commit changes if necessary (for UPDATE, DELETE, etc.)
                connection.commit()

                # merge all tables to one single table
                for table in cursor.stored_results():
                    results.extend(table.fetchall())

    except mysql.connector.Error as err:
        print(f"Error: {err}")
        raise

    print()
    return results  # Return the results to the caller
