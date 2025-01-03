from flask import Blueprint, request
from .services.add_service import add_service

from ..helpers.unexpected_error_response import unexpected_error_response

# create blueprint (group of routes)
services = Blueprint("services", __name__)


@services.route("/add_service", methods=["POST"])
def request_sign_up():
    try:
        # read json from request
        data = request.get_json()
        name = data.get("name")
        category_id = data.get("category_id")
        AOSs = data.get("AOSs")

        return add_service(name, category_id, AOSs)

    # catch unexpected error
    except Exception as e:
        return unexpected_error_response(e)
