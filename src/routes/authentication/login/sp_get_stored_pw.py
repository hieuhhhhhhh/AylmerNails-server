from src.mysql.execute_sql_file.many_queries import exe_queries
from src.mysql.call_sp import call_sp


# to build the required procedures:
def create_sp_get_stored_pw():
    print("\033[94m" + "create_sp_get_stored_pw" + "\033[0m")
    exe_queries(__file__, "sp_get_stored_pw.sql")


# return a tuple [user_id, password]:
def get_stored_pw(phone_number):
    res = call_sp("sp_get_new_pw", phone_number)
    return res[0] if res else None
