from flask import current_app, jsonify
from hashids import Hashids
from src.mysql.call_sp import call_sp


def continue_session(token):
    # Initialize Hashids with a salt and optional configuration
    hashids = Hashids(salt=current_app.config["TOKEN_SALT"], min_length=20)

    # Decode token get the required information
    session_id, session_salt = hashids.decode(token)

    # Process the retrieved data
    res = call_sp("sp_continue_session", session_id, session_salt, 24 * 60 * 60)

    # The procedure should return new salt
    if len(res):
        # Encode session ID and new salt to generate new token
        session_id, session_salt = res[0]
        token = hashids.encode(session_id, session_salt)

        return jsonify({"token": token}), 200

    # if the token is invalid return client the refreshed token
    else:
        return jsonify({"message": "Invalid token"}), 404
