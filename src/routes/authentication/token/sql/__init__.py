from src.mysql.execute_sql_file.many_queries import exe_queries


# to build the required procedures:
def create_token_procedures():
    print("\033[94m" + "create_token_procedures" + "\033[0m")
    exe_queries(__file__, "fn_get_unconfirmed_salt.sql")
    exe_queries(__file__, "fn_get_user_id.sql")
    exe_queries(__file__, "sp_confirm_salt.sql")
    exe_queries(__file__, "sp_generate_salt.sql")
    exe_queries(__file__, "sp_log_out_all.sql")
    exe_queries(__file__, "sp_validate_salt.sql")
    exe_queries(__file__, "sp_process_token.sql")
