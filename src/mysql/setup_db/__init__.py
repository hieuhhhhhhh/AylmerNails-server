from src.mysql.execute_sql_file.many_queries import exe_queries
from src.mysql.execute_sql_file.one_query import exe_one_query


def setup_db_on_mysql():
    print("\033[94m" + "setup_db_on_mysql" + "\033[0m")
    # if the db already exists, skip setup:
    db_exist = exe_one_query(__file__, "does_db_exist.sql")[0][0]
    if not db_exist:
        print("test_db not exist, creating database...")
        exe_queries(__file__, "setup_db.sql")
