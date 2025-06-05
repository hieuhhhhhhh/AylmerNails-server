import re
from flask import jsonify
import bcrypt  # Import bcrypt for password hashing
from src.mysql.procedures.call_3D_proc import call_3D_proc
from src.routes.helpers.tokenize_name import tokenize_name


def sign_up(code_id, code, password, first_name, last_name):
    print("\033[94m" + "sign_up" + "\033[0m")

    # validate names
    first_name = first_name.strip()
    last_name = last_name.strip()
    name_pattern = re.compile(r"^[A-Za-z]+(?: [A-Za-z]+)*$")

    if not name_pattern.match(first_name) or not name_pattern.match(last_name):
        return (
            jsonify({"message": "Invalid name: only letters or spaces are allowed"}),
            400,
        )

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

    # encrypt password
    hashed = bcrypt.hashpw(password.encode("utf-8"), bcrypt.gensalt()).decode("utf-8")

    # tokenize name
    name_tokens = tokenize_name(first_name + " " + last_name)

    #  create new account
    call_3D_proc("sp_add_user", phone_num, hashed, first_name, last_name, name_tokens)

    return "sign up succesful", 200
