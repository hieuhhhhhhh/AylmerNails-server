from flask import jsonify
import bcrypt  # Import bcrypt for password hashing
from src.mysql.execute_sql_file.many_queries import exe_queries
from src.mysql.call_sp import call_sp


# build the procedure:
def create_sp_sign_up():
    print("\033[94m" + "create_sp_sign_up" + "\033[0m")
    exe_queries(__file__, "sp_sign_up.sql")


def insert_new_authentication(phone_num, password):
    try:
        print("\033[94m" + "insert_new_authentication" + "\033[0m")

        # Check if phone number or password is missing
        if not (phone_num and password):
            return (
                jsonify({"error": "No phone number or password provided"}),
                400,
            )  # Bad Request

        # Hash the password before storing it
        hashed = bcrypt.hashpw(password.encode("utf-8"), bcrypt.gensalt()).decode(
            "utf-8"
        )

        # Call the stored procedure with the phone number and hashed password
        call_sp("sp_sign_up", phone_num, hashed)

        return (
            jsonify({"message": "INSERT new authentication successfully"}),
            201,
        )
    except Exception as e:
        return jsonify({"error": str(e)}), 500  # Internal Server Error
