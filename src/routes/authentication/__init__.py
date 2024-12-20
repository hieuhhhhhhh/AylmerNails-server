from flask import Blueprint, request, jsonify
from .hello_table_test.sp_insert_msg import insert_message_to_db
from .hello_table_test.read_all_hello_table import read_all_hello_table
from .sms_verification.sp_verify_code import verify_code
from .sign_up.request_signup import request_signup
from .sign_up.verify_new_password import verify_new_password

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
    except Exception as e:
        # return unexpected error
        return jsonify({"error": str(e), "message": "An unknown error occurred"}), 500


@authentication.route("/verify_sign_up", methods=["POST"])
def verify_sign_up():
    try:
        # read json from request
        data = request.get_json()
        phone_num = data.get("phone_num")
        code = data.get("code")

        return verify_new_password(phone_num, code)
    except Exception as e:
        # return unexpected error
        return jsonify({"error": str(e), "message": "An unknown error occurred"}), 500


@authentication.route("/verify_sms_code", methods=["POST"])
def verify_sms_code():
    # read json from request
    data = request.get_json()
    phone_num = data.get("phone_num")
    code = data.get("code")

    return verify_code(phone_num, code)
