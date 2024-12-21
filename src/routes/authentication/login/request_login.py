from flask import jsonify, current_app
from src.mysql.call_sp import call_sp
from .get_stored_pw import get_stored_pw
import bcrypt
from hashids import Hashids


# handle credentials from client side:
def request_login(phone_number, password):
    # fetch salt from env
    TOKEN_SALT = current_app.config["TOKEN_SALT"]

    # Initialize Hashids with a salt and optional configuration
    hashids = Hashids(salt=TOKEN_SALT, min_length=8)

    # fetch required data from db by phone_number
    user_id, hashed = get_stored_pw(phone_number)

    # Validate the entered password against the stored hash
    if hashed and bcrypt.checkpw(password.encode("utf-8"), hashed.encode("utf-8")):
        # Generate session ID and salt
        session_id, session_salt = call_sp("sp_add_session", user_id)[0]

        # Encode session ID and salt to generate token
        token = hashids.encode(session_id, session_salt)
        return jsonify({"token": token}), 200

    # Invalid credentials
    return jsonify({"message": "Invalid phone number or password"}), 404
