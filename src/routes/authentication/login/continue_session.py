from flask import current_app, jsonify
from hashids import Hashids
from mysql.procedures.call_2D_proc import call_2D_proc
from ...helpers.response_with_token import response_with_token


def continue_session(token):
    if not token:
        return {"error": "Token not found in cookies"}, 400

    # Initialize Hashids with a salt and optional configuration
    hashids = Hashids(salt=current_app.config["TOKEN_SALT"], min_length=20)

    # Decode token get the required information
    session_id, session_salt = hashids.decode(token)

    # Process the retrieved data
    status, user_id, new_salt = call_2D_proc(
        "sp_process_token", session_id, session_salt
    )[0]

    # if token is valid but need refreshing
    if status == 205:
        # Encode session ID with new salt to generate new token
        token = hashids.encode(session_id, new_salt)

        return response_with_token(
            jsonify({"user_id": user_id, "new_token": token}), status, token
        )

    # if token is valid
    if status == 200:
        return jsonify({"user_id": user_id}), status

    # if the token is invalid
    return jsonify({"message": "Invalid token"}), status
