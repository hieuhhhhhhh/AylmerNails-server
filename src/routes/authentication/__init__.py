from flask import Blueprint, request
from .sign_up.request_sign_up import request_sign_up
from .sign_up.sign_up import sign_up
from .login.request_login import request_login
from .login.continue_session import continue_session
from .logout.logout import logout
from src.routes.authentication.session.read_token import read_token
from ..helpers.default_error_response import default_error_response

# create blueprint (group of routes)
authentication = Blueprint("authentication", __name__)


@authentication.route("/request_sign_up", methods=["POST"])
def request_sign_up_():
    try:
        # read json from request
        data = request.get_json()
        phone_num = data.get("phone_num")

        return request_sign_up(phone_num)

    # catch unexpected error
    except Exception as e:
        return default_error_response(e)


@authentication.route("/sign_up", methods=["POST"])
def sign_up_():
    try:
        # read json from request
        data = request.get_json()
        code_id = data.get("code_id")
        code = data.get("code")
        password = data.get("password")

        return sign_up(code_id, code, password)

    # catch unexpected error
    except Exception as e:
        return default_error_response(e)


@authentication.route("/log_out", methods=["GET"])
def log_out():
    try:
        # read token
        session = read_token()

        return logout(session)

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
