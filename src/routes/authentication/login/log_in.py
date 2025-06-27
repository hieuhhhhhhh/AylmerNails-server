from flask import jsonify, current_app
from src.mysql.procedures.call_3D_proc import call_3D_proc
import bcrypt
from ...helpers.response_with_token import response_with_token
from hashids import Hashids

# init session expiry (in secs)
SESSION_EXPIRY = 60 * 60


# return a tuple: user_id, password
def get_stored_pw(phone_number):
    res = call_3D_proc("sp_get_stored_pw", phone_number)[0]
    if not res:
        return None, None
    user_id, hashed = res[0]
    return user_id, hashed


# handle credentials from client side:
def log_in(phone_number, password):
    # validate login count
    count = call_3D_proc("sp_count_login_attempts", phone_number)[0][0][0]
    if count > 5:
        return (
            jsonify(
                {"message": "Maximum login attempts reached, please renew password"}
            ),
            401,
        )

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

        # fetch log-in information
        try:
            user_role = call_3D_proc("sp_get_login_info", user_id)[0][0][0]
        except Exception:
            return jsonify({"message": "Restricted phone number"}), 403

        return response_with_token(
            jsonify({"token": token, "user_role": user_role}), 200, token
        )

    # Invalid credentials
    return jsonify({"message": "Invalid phone number or password"}), 401
