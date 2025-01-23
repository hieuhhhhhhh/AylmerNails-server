import json
from flask import Blueprint, request
from ..helpers.default_error_response import default_error_response
from src.routes.authentication.session.read_token import read_token
from .services.add_service import add_service
from .lengths.add_service_length import add_service_length
from .services.get_services import get_services
from .services.search_services import search_services
from .services.get_service_details import get_service_details
from .services.update_service_info import update_service_info

# create blueprint (group of routes)
services = Blueprint("services", __name__)


@services.route("/get_services/<date>", methods=["GET"])
def get_services_(date):
    try:
        # return service list
        return get_services(date)
    # catch unexpected error
    except Exception as e:
        return default_error_response(e)


@services.route("/add_service", methods=["POST"])
def add_service_():
    try:
        # read token
        session = read_token()

        # read json from request
        data = request.get_json()
        name = data.get("name")
        category_id = data.get("category_id")
        description = data.get("description")
        date = data.get("date")
        length = data.get("length")
        AOSs = json.dumps(data.get("AOSs"))  # convert python list to json
        employee_ids = json.dumps(data.get("employee_ids"))

        return add_service(
            session,
            name,
            category_id,
            description,
            date,
            length,
            AOSs,
            employee_ids,
        )

    # catch unexpected error
    except Exception as e:
        return default_error_response(e)


@services.route("/update_service_info", methods=["POST"])
def update_service_info_(service_id):
    try:
        # read token
        session = read_token()

        # read json from request
        data = request.get_json()
        service_id = data.get("service_id")
        name = data.get("name")
        description = data.get("description")
        category_id = data.get("category_id")
        last_date = data.get("last_date")

        return update_service_info(
            session, service_id, name, description, category_id, last_date
        )

    # catch unexpected error
    except Exception as e:
        return default_error_response(e)


@services.route("/add_service_length", methods=["POST"])
def add_service_length_():
    try:
        # read token
        session = read_token()

        # read json from request
        data = request.get_json()
        service_id = data.get("service_id")
        effective_from = data.get("effective_from")
        length = data.get("length")
        SLVs = json.dumps(data.get("SLVs"))  # convert python list to json

        return add_service_length(session, service_id, effective_from, length, SLVs)

    # catch unexpected error
    except Exception as e:
        return default_error_response(e)


@services.route("/search_services/<query>", methods=["GET"])
def search_services_(query):
    try:
        return search_services(query)

    # catch unexpected error
    except Exception as e:
        return default_error_response(e)


@services.route("/get_service_details/<service_id>", methods=["GET"])
def get_service_details_(service_id):
    try:
        return get_service_details(service_id)
    # catch unexpected error
    except Exception as e:
        return default_error_response(e)
