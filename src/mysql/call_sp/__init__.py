import mysql.connector
from src.mysql.db_config import DATABASE_CONFIG


def call_sp(sp_name, *params):
    print(f"Calling procedure: {sp_name}")

    results = []
    try:
        # Connect to the database using context manager to handle closing
        with mysql.connector.connect(**DATABASE_CONFIG) as connection:
            with connection.cursor() as cursor:
                # Call the stored procedure with dynamic parameters
                cursor.callproc(sp_name, params)

                # Commit changes if necessary (for UPDATE, DELETE, etc.)
                connection.commit()

                # Fetch the results (if the stored procedure returns data)
                for result in cursor.stored_results():
                    results.extend(
                        result.fetchall()
                    )  # Flatten the result into the list

    except mysql.connector.Error as err:
        print(f"Error: {err}")
        raise

    print()
    return results  # Return the results to the caller
