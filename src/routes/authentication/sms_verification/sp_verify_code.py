from src.mysql.execute_sql_file.many_queries import exe_queries
from src.mysql.call_sp import call_sp


# to build required procedure
def create_sp_verify_code():
    print("\033[94m" + "sp_verify_code" + "\033[0m")
    exe_queries(__file__, "sp_verify_code.sql")


# Init lifetime of code (in sec)
CODE_LIFETIME = 300


def verify_code(phone_number, code):
    # Verify code in db to verify in next request (return a table)
    results = call_sp("sp_verify_code", phone_number, code, CODE_LIFETIME)

    # read the table:
    success = results[0][0]
    msg = results[0][1]

    # Return the message and status code as a tuple
    return success, msg
