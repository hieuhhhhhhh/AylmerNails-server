from src.mysql.execute_sql_file.many_queries import exe_queries
from src.mysql.call_sp import call_sp
from .sp_get_new_pw import get_new_password


# to build the required procedures:
def create_sp_new_authentication():
    print("\033[94m" + "create_sp_new_authentication" + "\033[0m")
    exe_queries(__file__, "sp_new_authentication.sql")


def create_new_authentication(phone_number):
    call_sp("sp_new_authentication.sql", phone_number, get_new_password(phone_number))
