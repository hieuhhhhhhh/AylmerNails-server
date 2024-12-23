from flask import jsonify, current_app, make_response
from src.mysql.call_sp import call_sp
import bcrypt
from hashids import Hashids

# init session expiry (in secs)
SESSION_EXPIRY = 60 * 60


# return a tuple: user_id, password
def get_stored_pw(phone_number):
    res = call_sp("sp_get_stored_pw", phone_number)
    return (res[0][0], res[0][1]) if res else (None, None)


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
        session_id, session_salt = call_sp("sp_add_session", user_id, SESSION_EXPIRY)[0]

        # Encode session ID and salt to generate token
        token = hashids.encode(session_id, session_salt)

        # Generate and return a response with token on cookie
        response = make_response(jsonify({"token": token}), 200)
        response.set_cookie("Hi", "hi", samesite="Lax")

        return response

    # Invalid credentials
    return jsonify({"message": "Invalid phone number or password"}), 401
