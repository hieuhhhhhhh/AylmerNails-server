from src.mysql.execute_sql_file.many_queries import exe_queries
from src.mysql.call_sp import call_sp


# to build the required procedures:
def create_sp_is_phonenum_avail():
    print("\033[94m" + "create_sp_is_phonenum_avail" + "\033[0m")
    exe_queries(__file__, "sp_is_phonenum_avail.sql")


def phonenum_is_avail(phone_number):
    return call_sp("sp_is_phonenum_avail", phone_number)[0][0]
