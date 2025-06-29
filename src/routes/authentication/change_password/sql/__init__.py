from src.mysql.execute_sql_file.many_queries import exe_queries


# to build the required procedures:
def create_authentication_change_password_sps():
    print("\033[36m" + "create_authentication_change_password_sps" + "\033[0m")
    exe_queries(__file__, "sp_change_password.sql")

    print()
