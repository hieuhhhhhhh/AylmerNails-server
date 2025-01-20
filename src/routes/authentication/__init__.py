from flask import Blueprint, request
from .sign_up.request_signup import request_signup
from .sign_up.verify_signup import verify_signup
from .login.request_login import request_login
from .login.continue_session import continue_session

from ..helpers.default_error_response import default_error_response

# create blueprint (group of routes)
authentication = Blueprint("authentication", __name__)


@authentication.route("/request_sign_up", methods=["POST"])
def request_sign_up():
    try:
        # read json from request
        data = request.get_json()
        phone_num = data.get("phone_num")
        password = data.get("password")

        return request_signup(phone_num, password)

    # catch unexpected error
    except Exception as e:
        return default_error_response(e)


@authentication.route("/verify_sign_up", methods=["POST"])
def verify_sign_up():
    try:
        # read json from request
        data = request.get_json()
        phone_num = data.get("phone_num")
        code = data.get("code")

        return verify_signup(phone_num, code)

    # catch unexpected error
    except Exception as e:
        return default_error_response(e)


@authentication.route("/request_log_in", methods=["POST"])
def request_log_in():
    try:
        # read json from request
        data = request.get_json()
        phone_num = data.get("phone_num")
        password = data.get("password")

        return request_login(phone_num, password)

    # catch unexpected error
    except Exception as e:
        return default_error_response(e)


@authentication.route("/request_continue_session")
def request_continue_session():
    try:
        # read token from cookie
        token = request.cookies.get("TOKEN")

        return continue_session(token)

    # catch unexpected error
    except Exception as e:
        return default_error_response(e)
