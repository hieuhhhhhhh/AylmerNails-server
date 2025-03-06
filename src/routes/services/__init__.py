import json
from flask import Blueprint, request
from ..helpers.default_error_response import default_error_response
from src.routes.authentication.session.read_token import read_token
from .services.add_service import add_service
from .services.get_services import get_services
from .services.search_services import search_services
from .services.get_service_details import get_service_details
from .services.update_service_info import update_service_info
from .services.get_SEs import get_service_employees
from .services.update_SEs import update_service_employees
from .services.get_service_preview import get_service_preview
from .services.get_AOSs import get_AOSs
from .durations.update_durations import update_durations

from .categories.get_categories import get_categories
from .categories.add_category import add_category
from .categories.remove_category import remove_category

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


@services.route("/get_categories", methods=["GET"])
def get_categories_():
    try:
        # return cate list
        return get_categories()
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
        duration = data.get("duration")
        AOSs = json.dumps(data.get("AOSs"))  # convert python list to json
        employee_ids = json.dumps(data.get("employee_ids"))

        return add_service(
            session,
            name,
            category_id,
            description,
            date,
            duration,
            AOSs,
            employee_ids,
        )

    # catch unexpected error
    except Exception as e:
        return default_error_response(e)


@services.route("/update_service_info", methods=["POST"])
def update_service_info_():
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


@services.route("/update_durations", methods=["POST"])
def update_durations_():
    try:
        # read token
        session = read_token()

        # read json from request
        data = request.get_json()
        service_id = data.get("service_id")
        default_duration = data.get("default_duration")
        durations = json.dumps(data.get("durations"))  # convert python list to json

        return update_durations(session, service_id, default_duration, durations)

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


@services.route("/get_service_details/<int:service_id>", methods=["GET"])
def get_service_details_(service_id):
    try:
        return get_service_details(service_id)
    # catch unexpected error
    except Exception as e:
        return default_error_response(e)


@services.route("/get_service_preview/<int:service_id>/<int:date>", methods=["GET"])
def get_service_preview_(service_id, date):
    try:
        return get_service_preview(service_id, date)
    # catch unexpected error
    except Exception as e:
        return default_error_response(e)


@services.route("/get_service_employees/<int:service_id>/<int:date>", methods=["GET"])
def get_service_employees_(service_id, date):
    try:
        return get_service_employees(service_id, date)
    # catch unexpected error
    except Exception as e:
        return default_error_response(e)


@services.route("/update_service_employees", methods=["POST"])
def update_service_employees_():
    try:
        # read token:
        session = read_token()
        # read json from request
        data = request.get_json()
        service_id = data.get("service_id")
        employee_ids = json.dumps(data.get("employee_ids"))

        return update_service_employees(session, service_id, employee_ids)
    # catch unexpected error
    except Exception as e:
        return default_error_response(e)


@services.route("/add_category", methods=["POST"])
def add_category_():
    try:
        # read token:
        session = read_token()
        # read json from request
        data = request.get_json()
        name = data.get("name")
        return add_category(session, name)
    # catch unexpected error
    except Exception as e:
        return default_error_response(e)


@services.route("/remove_category", methods=["POST"])
def remove_category_():
    try:
        # read token:
        session = read_token()
        # read json from request
        data = request.get_json()
        cate_id = data.get("cate_id")

        return remove_category(session, cate_id)
    # catch unexpected error
    except Exception as e:
        return default_error_response(e)


@services.route("/get_add_on_services/<service_id>", methods=["GET"])
def get_add_on_services_(service_id):
    try:
        return get_AOSs(service_id)
    # catch unexpected error
    except Exception as e:
        return default_error_response(e)
