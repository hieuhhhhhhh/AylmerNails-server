from flask import Blueprint, request
from .hello_table_test.sp_insert_msg import insert_message_to_db
from .hello_table_test.read_all_hello_table import read_all_hello_table
from .sign_up.request_signup import request_signup
from .sign_up.verify_signup import verify_signup
from .login.request_login import request_login

from ..helpers.unexpected_error_response import unexpected_error_response

# create blueprint (group of routes)
authentication = Blueprint("authentication", __name__)


# add routes
@authentication.route("/insert_hello_table", methods=["POST"])
def iht():
    # read json from request
    data = request.get_json()
    msg = data.get("message")

    # process request
    return insert_message_to_db(msg)


@authentication.route("/mysql")
def mysql():
    print("\033[94m" + "read_all_hello_table" + "\033[0m")
    return read_all_hello_table()


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
        return unexpected_error_response(e)


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
        return unexpected_error_response(e)


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
        return unexpected_error_response(e)
