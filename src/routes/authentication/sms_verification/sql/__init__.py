from src.mysql.execute_sql_file.many_queries import exe_queries


# to build the required procedures:
def create_authentication_sms_verification_sps():
    print("\033[36m" + "create_authentication_sms_verification_sps" + "\033[0m")
    exe_queries(__file__, "sp_store_code.sql")
    exe_queries(__file__, "sp_verify_code.sql")
    print()
