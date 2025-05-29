from src.mysql.execute_sql_file.many_queries import exe_queries


# to build the required procedures:
def create_authentication_otp_codes_sps():
    print("\033[36m" + "create_authentication_otp_codes_sps" + "\033[0m")
    exe_queries(__file__, "sp_request_otp_code.sql")
    exe_queries(__file__, "sp_verify_otp_code.sql")
    print()
