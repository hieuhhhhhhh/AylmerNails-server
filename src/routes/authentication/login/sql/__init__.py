from src.mysql.execute_sql_file.many_queries import exe_queries


# to build the required procedures:
def create_authentication_login_sps():
    print("\033[36m" + "create_authentication_login_sps" + "\033[0m")
    exe_queries(__file__, "sp_add_session.sql")
    exe_queries(__file__, "sp_get_stored_pw.sql")
    exe_queries(__file__, "sp_login_by_token.sql")
    print()
