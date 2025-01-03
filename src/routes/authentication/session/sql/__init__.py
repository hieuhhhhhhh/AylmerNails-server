from src.mysql.execute_sql_file.many_queries import exe_queries


# to build the required procedures:
def create_authentication_session_sps():
    print("\033[36m" + "create_authentication_session_sps" + "\033[0m")
    exe_queries(__file__, "fn_get_unconfirmed_salt.sql")
    exe_queries(__file__, "sp_confirm_salt.sql")
    exe_queries(__file__, "sp_generate_salt.sql")
    exe_queries(__file__, "sp_log_out_all.sql")
    exe_queries(__file__, "sp_validate_salt.sql")
    print()
