from src.mysql.execute_sql_file.many_queries import exe_queries


# to build the required procedures:
def create_sp_get_new_pw():
    print("\033[94m" + "create_sp_get_new_pw" + "\033[0m")
    exe_queries(__file__, "sp_get_new_pw.sql")


# to build the required procedures:
def create_sp_new_auth():
    print("\033[94m" + "create_sp_new_auth" + "\033[0m")
    exe_queries(__file__, "sp_new_auth.sql")
