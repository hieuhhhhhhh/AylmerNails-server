from src.mysql.execute_sql_file.many_queries import exe_queries


def create_tables():
    print("\033[94m" + "create_tables" + "\033[0m")

    exe_queries(__file__, "authentication/authentication.sql")
    exe_queries(__file__, "authentication/sms_verify_codes.sql")
    exe_queries(__file__, "authentication/user_sessions.sql")
    exe_queries(__file__, "authentication/unconfirmed_salts.sql")
