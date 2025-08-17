from flask import make_response
from datetime import datetime, timedelta, timezone

# Set the how long the cookie should be in the client's browser (in seconds)
COOKIE_AGE = 6 * 30 * 24 * 60 * 60  # 6 months


def response_with_token(body, status, token):
    response = make_response(body, status)

    # Make the current datetime UTC and timezone-aware
    expires = datetime.now(timezone.utc) + timedelta(seconds=COOKIE_AGE)

    # # for production
    # response.set_cookie("TOKEN", token, expires=expires, samesite="Lax", httponly=True)

    # for dev
    response.set_cookie(
        "TOKEN", token, expires=expires, samesite="None", httponly=True, secure=True
    )

    return response
