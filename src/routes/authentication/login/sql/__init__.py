from src.mysql.execute_sql_file.many_queries import exe_queries


# to build the required procedures:
def create_sp_add_session():
    print("\033[94m" + "create_sp_add_session" + "\033[0m")
    exe_queries(__file__, "sp_add_session.sql")


# to build the required procedures:
def create_sp_get_stored_pw():
    print("\033[94m" + "create_sp_get_stored_pw" + "\033[0m")
    exe_queries(__file__, "sp_get_stored_pw.sql")


# to build the required procedures:
def create_sp_continue_session():
    print("\033[94m" + "create_sp_continue_session" + "\033[0m")
    exe_queries(__file__, "sp_continue_session.sql")
