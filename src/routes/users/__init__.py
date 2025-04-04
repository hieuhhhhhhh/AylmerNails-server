import json
from flask import Blueprint, request
from ..helpers.default_error_response import default_error_response
from src.routes.authentication.session.read_token import read_token
from .my_profile.update_my_profile import update_my_profile
from src.routes.appointments.notifications.get_users import get_users
from .my_profile.get_my_profile import get_my_profile
from .profiles.get_user_details import get_user_details
from .profiles.search_users import search_users
from .profiles.get_users_last_tracked import get_users_last_tracked


# create blueprint (group of routes)
users = Blueprint("users", __name__)


@users.route("/get_my_profile", methods=["GET"])
def get_my_profile_():
    try:
        # read token
        session = read_token()

        # return service list
        return get_my_profile(session)
    # catch unexpected error
    except Exception as e:
        return default_error_response(e)


@users.route("/get_user_details/<int:user_id>", methods=["GET"])
def get_user_details_(user_id):
    try:
        # read token
        session = read_token()

        # return service list
        return get_user_details(session, user_id)
    # catch unexpected error
    except Exception as e:
        return default_error_response(e)


@users.route("/update_my_profile", methods=["POST"])
def update_my_profile_():
    try:
        # read token
        session = read_token()
        # read json from request
        data = request.get_json()
        first_name = data.get("first_name")
        last_name = data.get("last_name")

        # return service list
        return update_my_profile(session, first_name, last_name)
    # catch unexpected error
    except Exception as e:
        return default_error_response(e)


@users.route("/get_users/<limit>", methods=["GET"])
def get_users_(limit):
    try:
        # read token
        session = read_token()

        # process input and return result
        return get_users(session, limit)

    # catch unexpected error
    except Exception as e:
        return default_error_response(e)


@users.route("/search_users", methods=["POST"])
def search_users_():
    try:
        # read json from request
        data = request.get_json()
        query = data.get("query")
        limit = data.get("limit")

        # process input and return result
        return search_users(query, limit)

    # catch unexpected error
    except Exception as e:
        return default_error_response(e)


@users.route("/get_last_tracked", methods=["GET"])
def get_last_tracked():
    try:
        # read token
        session = read_token()

        # process input and return result
        return get_users_last_tracked(session)

    # catch unexpected error
    except Exception as e:
        return default_error_response(e)
