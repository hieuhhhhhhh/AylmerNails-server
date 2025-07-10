import re
from flask import jsonify
import bcrypt  # Import bcrypt for password hashing
from src.mysql.procedures.call_3D_proc import call_3D_proc
from src.socketio import emit_signing_up


def create_account(session, phone_num, password, first_name, last_name):
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

    # encrypt password
    hashed = bcrypt.hashpw(password.encode("utf-8"), bcrypt.gensalt()).decode("utf-8")

    #  create new account
    user_id = call_3D_proc(
        "sp_owner_create_account",
        session,
        phone_num,
        hashed,
        first_name,
        last_name,
    )

    # push notification
    emit_signing_up()

    return jsonify({"user_id": user_id}), 200
