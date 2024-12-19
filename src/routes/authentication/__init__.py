from flask import Blueprint, request
from .hello_table_test.sp_insert_msg import insert_message_to_db
from .hello_table_test.read_all_hello_table import read_all_hello_table


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
