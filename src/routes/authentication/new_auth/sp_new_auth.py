from src.mysql.execute_sql_file.many_queries import exe_queries
from src.mysql.call_sp import call_sp
from .sp_get_new_pw import get_new_password


# to build the required procedures:
def create_sp_new_auth():
    print("\033[94m" + "create_sp_new_auth" + "\033[0m")
    exe_queries(__file__, "sp_new_auth.sql")


def create_new_auth(phone_number):
    new_pw = get_new_password()

    # if a new password was inserted earlier, overwrite the old password
    if new_pw:
        call_sp("sp_new_auth.sql", phone_number, new_pw)
