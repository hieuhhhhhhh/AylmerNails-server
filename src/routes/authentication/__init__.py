from flask import Blueprint, request
from .sign_up.request_sign_up import request_sign_up
from .sign_up.sign_up import sign_up
from .sign_up.owner_create_account import create_account
from .login.log_in import log_in
from .login.continue_session import continue_session
from .logout.logout import logout
from .logout.logout_everywhere import logout_everywhere
from .forgot_password.renew_password import renew_password
from .forgot_password.request_forgot_password import request_forgot_password
from .change_password.change_password import change_password
from src.routes.authentication.session.read_token import read_token
from ..helpers.default_error_response import default_error_response
from .otp_codes.request_code import request_otp_code

# create blueprint (group of routes)
authentication = Blueprint("authentication", __name__)


@authentication.route("/request_otp", methods=["POST"])
def request_otp():
    try:
        # read json from request
        data = request.get_json()
        phone_num = data.get("phone_num")

        return request_otp_code(phone_num)

    # catch unexpected error
    except Exception as e:
        return default_error_response(e)


@authentication.route("/request_sign_up", methods=["POST"])
def request_sign_up_():
    try:
        # read json from request
        data = request.get_json()
        phone_num = data.get("phone_num")
        first_name = data.get("first_name")
        last_name = data.get("last_name")

        return request_sign_up(phone_num, first_name, last_name)

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
        first_name = data.get("first_name")
        last_name = data.get("last_name")

        return sign_up(code_id, code, password, first_name, last_name)

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


@authentication.route("/log_out_everywhere", methods=["GET"])
def log_out_everywhere_():
    try:
        # read token
        session = read_token()

        return logout_everywhere(session)

    # catch unexpected error
    except Exception as e:
        return default_error_response(e)


@authentication.route("/log_in", methods=["POST"])
def log_in_():
    try:
        # read json from request
        data = request.get_json()
        phone_num = data.get("phone_num")
        password = data.get("password")
        remember_me = data.get("remember_me")

        print(phone_num)

        return log_in(phone_num, password, remember_me)

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


@authentication.route("/request_forgot_password", methods=["POST"])
def request_forgot_password_():
    try:
        # read json from request
        data = request.get_json()
        phone_num = data.get("phone_num")

        return request_forgot_password(phone_num)

    # catch unexpected error
    except Exception as e:
        return default_error_response(e)


@authentication.route("/renew_password", methods=["POST"])
def renew_password_():
    try:
        # read json from request
        data = request.get_json()
        code_id = data.get("code_id")
        code = data.get("code")
        password = data.get("password")

        return renew_password(
            code_id,
            code,
            password,
        )

    # catch unexpected error
    except Exception as e:
        return default_error_response(e)


@authentication.route("/create_user", methods=["POST"])
def create_user():
    try:
        # read token
        session = read_token()

        # read json from request
        data = request.get_json()
        password = data.get("password")
        phone_num = data.get("phone_num")
        first_name = data.get("first_name")
        last_name = data.get("last_name")

        return create_account(
            session,
            phone_num,
            password,
            first_name,
            last_name,
        )

    # catch unexpected error
    except Exception as e:
        return default_error_response(e)


@authentication.route("/change_password", methods=["POST"])
def change_password_():
    try:
        # read token
        session = read_token()

        # read json from request
        data = request.get_json()
        password = data.get("password")
        new_password = data.get("new_password")

        return change_password(session, password, new_password)

    # catch unexpected error
    except Exception as e:
        return default_error_response(e)
