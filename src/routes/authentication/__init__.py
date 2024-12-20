from flask import Blueprint, request
from .hello_table_test.sp_insert_msg import insert_message_to_db
from .hello_table_test.read_all_hello_table import read_all_hello_table
from .sign_up.sp_sign_up import insert_new_authentication
from .sms_verification.sp_store_code import send_code_by_sms

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


# add routes
@authentication.route("/sign_up", methods=["POST"])
def sign_up():
    # read json from request
    data = request.get_json()
    phone_num = data.get("phone_num")
    password = data.get("password")

    # process request
    return insert_new_authentication(phone_num, password)


@authentication.route("/verify_phone_number_by_sms", methods=["POST"])
def text_me():
    # read json from request
    data = request.get_json()
    phone_num = data.get("phone_num")

    return send_code_by_sms(phone_num)
