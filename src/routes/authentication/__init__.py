from flask import Blueprint, jsonify, request
from .hello_table_test.sp_insert_msg import (
    insert_message_to_db,
    create_sp_insert_msg,
)
from .hello_table_test.read_all_hello_table import read_all_hello_table

# build required procedure:
create_sp_insert_msg()

# create blueprint (group of routes)
auth_routes = Blueprint("authentication", __name__)


@auth_routes.route("/insert_hello_table", methods=["POST"])
def insert_hello_table():
    data = request.get_json()  # Get JSON data from the request body
    msg = data.get("message")  # Get the 'message' from JSON
    if msg:
        try:
            insert_message_to_db(msg)
            return jsonify({"message": "INSERT successfully"}), 201  # Created
        except Exception as e:
            return jsonify({"error": str(e)}), 500  # Internal Server Error
    return jsonify({"error": "No message provided"}), 400  # Bad Request


# Serve the message from MySQL on the index route
@auth_routes.route("/mysql")
def mysql():
    print("\033[94m" + "read_all_hello_table" + "\033[0m")
    return jsonify(read_all_hello_table()), 200
