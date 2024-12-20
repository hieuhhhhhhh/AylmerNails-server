from src.mysql.execute_sql_file.many_queries import exe_queries
from src.mysql.call_sp import call_sp


# to build the required procedures:
def create_sp_get_new_pw():
    print("\033[94m" + "create_sp_get_new_pw" + "\033[0m")
    exe_queries(__file__, "sp_get_new_pw.sql")


def get_new_password(phone_number):
    result = call_sp("sp_get_new_pw", phone_number)
    return result[0][0] if result else None
