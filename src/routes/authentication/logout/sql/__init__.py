from src.mysql.execute_sql_file.many_queries import exe_queries


# to build the required procedures:
def create_authentication_logout_sps():
    print("\033[36m" + "create_authentication_logout_sps" + "\033[0m")
    exe_queries(__file__, "sp_log_out.sql")
    exe_queries(__file__, "sp_log_out_everywhere.sql")

    print()
