from flask import jsonify, current_app
from src.mysql.procedures.call_3D_proc import call_3D_proc
import bcrypt
from ...helpers.response_with_token import response_with_token
from hashids import Hashids

# init session expiry (in secs)
SESSION_EXPIRY = 60 * 60


# return a tuple: user_id, password
def get_stored_pw(phone_number):
    res = call_3D_proc("sp_get_stored_pw", phone_number)
    return (res[0][0][0], res[0][0][1]) if res[0] else (None, None)


# handle credentials from client side:
def request_login(phone_number, password):
    # fetch salt from env
    TOKEN_SALT = current_app.config["TOKEN_SALT"]

    # Initialize Hashids with a salt and optional configuration
    hashids = Hashids(salt=TOKEN_SALT, min_length=20)

    # fetch required data from db by phone_number
    user_id, hashed = get_stored_pw(phone_number)

    # Validate the entered password against the stored hash
    if hashed and bcrypt.checkpw(password.encode("utf-8"), hashed.encode("utf-8")):
        # Generate session ID and salt
        session_id, session_salt = call_3D_proc(
            "sp_add_session", user_id, SESSION_EXPIRY
        )[0][0]

        # Encode session ID and salt to generate token
        token = hashids.encode(session_id, session_salt)

        return response_with_token(jsonify({"token": token}), 200, token)

    # Invalid credentials
    return jsonify({"message": "Invalid phone number or password"}), 401
