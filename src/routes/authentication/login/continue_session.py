from flask import current_app, jsonify
from hashids import Hashids
from src.mysql.call_sp import call_sp


def continue_session(token):
    # fetch salt from env
    TOKEN_SALT = current_app.config["TOKEN_SALT"]

    # Initialize Hashids with a salt and optional configuration
    hashids = Hashids(salt=TOKEN_SALT, min_length=20)

    # Decode token get the required information
    session_id, session_salt = hashids.decode(token)

    # Process the retrieved data
    session_id, session_salt = call_sp("sp_continue_session", session_id, session_salt)

    # The procedure should return new salt if not the token is invalid
    if session_id is None or session_salt is None:
        return jsonify({"message": "Invalid token"}), 404

    # if the token is valid return client the refreshed token
    else:
        # Encode session ID and new salt to generate new token
        token = hashids.encode(session_id, session_salt)
        return jsonify({"token": token}), 200
