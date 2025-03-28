import json
from flask import Blueprint, request
from ..helpers.default_error_response import default_error_response
from src.routes.authentication.session.read_token import read_token
from .get_all import get_all
from .update_business_links import update_business_links

# create blueprint (group of routes)
business_links = Blueprint("business_links", __name__)


@business_links.route("/get_all", methods=["GET"])
def get_all_():
    try:
        # return service list
        return get_all()
    # catch unexpected error
    except Exception as e:
        return default_error_response(e)


@business_links.route("/update_business_links", methods=["POST"])
def update_business_links_():
    try:
        # read token
        session = read_token()

        # read json from request
        data = request.get_json()
        phone_num = data.get("phoneNum")
        address = data.get("address")
        instagram = data.get("instagram")
        email = data.get("email")

        # return service list
        return update_business_links(session, phone_num, address, instagram, email)
    # catch unexpected error
    except Exception as e:
        return default_error_response(e)
