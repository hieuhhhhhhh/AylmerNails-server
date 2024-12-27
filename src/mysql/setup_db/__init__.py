from src.mysql.execute_sql_file.one_query import exe_one_query
from ..tables import create_tables
from ..procedures.create_procs import create_procedures


# create required database if not exists
def setup_db_on_mysql():
    print("\033[36m" + "setup_db_on_mysql" + "\033[0m")

    # if the db already exists, skip setup:
    db_exist = exe_one_query(__file__, "does_db_exist.sql")[0][0]
    if not db_exist:
        print("aylmer_nails not exist, creating database...")
        exe_one_query(__file__, "create_db.sql")
        # create required tables
        create_tables()

    # build/update procedures:
    create_procedures()
