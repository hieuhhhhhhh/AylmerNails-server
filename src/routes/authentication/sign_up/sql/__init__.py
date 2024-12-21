from src.mysql.execute_sql_file.many_queries import exe_queries


# to build the required procedures:
def create_sp_is_phonenum_avail():
    print("\033[94m" + "create_sp_is_phonenum_avail" + "\033[0m")
    exe_queries(__file__, "sp_is_phonenum_avail.sql")


# to build the required procedures:
def create_sp_new_auth():
    print("\033[94m" + "create_sp_new_auth" + "\033[0m")
    exe_queries(__file__, "sp_new_auth.sql")
