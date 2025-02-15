import json
from flask import Blueprint, request
from ..helpers.default_error_response import default_error_response
from src.routes.authentication.session.read_token import read_token
from .availability.get_availability_list import get_availability_list
from .appos.add_appo_by_DELA import add_appo_by_DELA
from .appos.add_appo_by_chain import add_appo_by_chain
from .appos.get_daily_appos import get_daily_appos

# create blueprint (group of routes)
appointments = Blueprint("appointments", __name__)


@appointments.route("/get_availability_list", methods=["POST"])
def get_availability():
    try:
        # read json from request
        data = request.get_json()
        DELAs_requests = data.get("DELAs_requests")

        # process input and return result
        return get_availability_list(DELAs_requests)

    # catch unexpected error
    except Exception as e:
        return default_error_response(e)


@appointments.route("/add_appo_by_DELA", methods=["POST"])
def add_appo_by_DELA_():
    try:
        # read token
        session = read_token()

        # read json from request
        data = request.get_json()
        employee_id = data.get("employee_id")
        service_id = data.get("service_id")
        selected_AOSO = json.dumps(
            data.get("selected_AOSO")
        )  # convert python list to json
        date = data.get("date")
        start_time = data.get("start_time")

        # process input and return result
        return add_appo_by_DELA(
            session, employee_id, service_id, selected_AOSO, date, start_time
        )

    # catch unexpected error
    except Exception as e:
        return default_error_response(e)


@appointments.route("/add_appo_by_chain", methods=["POST"])
def add_appo_by_chain_():
    try:
        # read token
        session = read_token()

        # read json from request
        data = request.get_json()
        slots = data.get("slots")
        date = data.get("date")

        # process input and return result
        return add_appo_by_chain(session, slots, date)

    # catch unexpected error
    except Exception as e:
        return default_error_response(e)


@appointments.route("/get_daily_appos/<date>", methods=["GET"])
def get_daily_appos_(date):
    try:
        # read token
        session = read_token()

        # process input and return result
        return get_daily_appos(session, date)

    # catch unexpected error
    except Exception as e:
        return default_error_response(e)
