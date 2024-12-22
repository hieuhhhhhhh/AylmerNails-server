from src.mysql.execute_sql_file.many_queries import exe_queries


# to build the required procedures:
def create_session_procedures():
    print("\033[94m" + "create_session_procedures" + "\033[0m")
    exe_queries(__file__, "fn_get_unconfirmed_salt.sql")
    exe_queries(__file__, "sp_confirm_salt.sql")
    exe_queries(__file__, "sp_generate_salt.sql")
    exe_queries(__file__, "sp_log_out_all.sql")
    exe_queries(__file__, "sp_validate_salt.sql")
    exe_queries(__file__, "sp_process_token.sql")
