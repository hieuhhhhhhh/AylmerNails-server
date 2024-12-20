from flask import jsonify
from src.mysql.execute_sql_file.many_queries import exe_queries
from src.mysql.call_sp import call_sp


# to build required procedure
def create_sp_verify_code():
    print("\033[94m" + "sp_verify_code" + "\033[0m")
    exe_queries(__file__, "sp_verify_code.sql")


# Init lifetime of code (in sec)
CODE_LIFETIME = 300


def verify_code(phone_number, code):
    try:
        # placeholders for response from procedure
        success = False
        msg = ""

        # Store code in db to verify in next request
        call_sp("sp_verify_code", phone_number, code, CODE_LIFETIME, success, msg)

        if success:
            return (
                jsonify({"message": msg}),
                200,
            )
        else:
            return (
                jsonify({"message": msg}),
                400,
            )
    except Exception as e:
        # prepare default message:
        msg = "An error occurred, please try again"

        # return code 500 Internal Server Error
        return jsonify({"error": str(e), "message": msg}), 500
