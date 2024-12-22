from flask import current_app, jsonify
from hashids import Hashids
from src.mysql.call_sp import call_sp


def continue_session(token):
    # Initialize Hashids with a salt and optional configuration
    hashids = Hashids(salt=current_app.config["TOKEN_SALT"], min_length=20)

    # Decode token get the required information
    session_id, session_salt = hashids.decode(token)

    # Process the retrieved data
    status, user_id, new_salt = call_sp("sp_process_token", session_id, session_salt)[0]

    # if token is valid but need refreshing
    if status == 205:
        # Encode session ID with new salt to generate new token
        token = hashids.encode(session_id, new_salt)

        return jsonify({"new_token": token}), status

    # if token is valid
    if status == 200:
        return jsonify({"user_id": user_id}), status

    # if the token is invalid
    return jsonify({"message": "Invalid token"}), status
