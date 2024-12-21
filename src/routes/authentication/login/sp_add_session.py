from src.mysql.execute_sql_file.many_queries import exe_queries
from src.mysql.call_sp import call_sp


# to build the required procedures:
def create_sp_add_session():
    print("\033[94m" + "create_sp_add_session" + "\033[0m")
    exe_queries(__file__, "sp_add_session.sql")


def request_log_in(phone_number, password):

    hashed = bcrypt.hashpw(password.encode("utf-8"), bcrypt.gensalt()).decode("utf-8")

    result = call_sp("sp_get_new_pw", phone_number, hashed)
    if result:
        session_id, session_salt = result[0]
