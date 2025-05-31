from flask import jsonify
import bcrypt  # Import bcrypt for password hashing
from src.routes.authentication.login.request_login import request_login
from src.mysql.procedures.call_3D_proc import call_3D_proc


def sign_up(code_id, code, password):
    print("\033[94m" + "sign_up" + "\033[0m")
    #  validate password
    if len(password) < 6:
        return jsonify({"message": "Password must be at least 6 characters long"}), 400

    # check if verification code is correct
    true_code, phone_num = call_3D_proc(
        "sp_get_otp_code",
        code_id,
    )[
        0
    ][0]

    # validate code
    if true_code is None:
        return jsonify({"message": "Maximum attempts reached, try resending code"}), 400

    if code != true_code:
        return jsonify({"message": "Incorrect code, please try again"}), 400

    # clean up otp code
    call_3D_proc(
        "sp_remove_otp_code",
        code_id,
    )

    # encrypt password and create new account
    hashed = bcrypt.hashpw(password.encode("utf-8"), bcrypt.gensalt()).decode("utf-8")
    call_3D_proc(
        "sp_add_user",
        phone_num,
        hashed,
    )

    return "sign up succesful", 200
