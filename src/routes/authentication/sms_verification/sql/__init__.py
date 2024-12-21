from src.mysql.execute_sql_file.many_queries import exe_queries


# to build the required procedures:
def create_sp_store_code():
    print("\033[94m" + "create_sp_store_code" + "\033[0m")
    exe_queries(__file__, "sp_store_code.sql")


# to build required procedure
def create_sp_verify_code():
    print("\033[94m" + "sp_verify_code" + "\033[0m")
    exe_queries(__file__, "sp_verify_code.sql")
