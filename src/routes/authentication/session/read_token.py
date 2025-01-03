import json
from flask import current_app, request
from hashids import Hashids


def read_token():
    # Result holders
    session_id = None
    session_salt = None

    # Fetch token
    # token = request.cookies.get("TOKEN")
    token = "NKrDXBp5Cj4erp9ARMWa"

    if token:
        # Initialize Hashids with a salt and optional configuration
        hashids = Hashids(salt=current_app.config["TOKEN_SALT"], min_length=20)

        # Decode token to get the required information
        session_id, session_salt = hashids.decode(token)

    # Return results as a JSON string
    return json.dumps({"id": session_id, "salt": session_salt})
