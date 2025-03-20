import json
from src.mysql.procedures.call_3D_proc import call_3D_proc
from flask import current_app
from hashids import Hashids


def get_new_appo_count(token):
    session = read_token(token)

    # call mysql proc to process data
    count = call_3D_proc("sp_get_new_appo_count", session)[0][0][0]

    return count


def read_token(token):
    # Result holders
    session_id = None
    session_salt = None

    # Fetch token

    if token:
        # Initialize Hashids with a salt and optional configuration
        hashids = Hashids(salt=current_app.config["TOKEN_SALT"], min_length=20)

        # Decode token to get the required information
        session_id, session_salt = hashids.decode(token)

    # Return results as a JSON string
    return json.dumps({"id": session_id, "salt": session_salt})
