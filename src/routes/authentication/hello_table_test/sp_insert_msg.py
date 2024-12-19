from src.mysql.execute_sql_file.many_queries import exe_queries
from src.mysql.call_sp import call_sp


# build the procedure:
def create_sp_insert_msg():
    print("\033[94m" + "create_sp_insert_msg" + "\033[0m")
    exe_queries(__file__, "sp_insert_msg.sql")


def insert_message_to_db(message):
    print("\033[94m" + "insert_message_to_db" + "\033[0m")

    # Call the stored procedure
    call_sp("sp_process_message", message)
