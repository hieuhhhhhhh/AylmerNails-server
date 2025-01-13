import json
from flask import Blueprint, request
from ..helpers.unexpected_error_response import unexpected_error_response
from src.routes.authentication.session.read_token import read_token
from .availability.get_daily_DELAs import get_daily_DELAs

# create blueprint (group of routes)
appointments = Blueprint("appointments", __name__)


@appointments.route("/get_availability", methods=["POST"])
def get_availability():
    try:
        # read token
        session = read_token()

        # read json from request
        data = request.get_json()
        date = data.get("date")
        service_id = data.get("service_id")
        selected_AOSO = json.dumps(
            data.get("selected_AOSO")
        )  # convert python list to json
        employee_ids = json.dumps(
            data.get("employee_ids")
        )  # convert python list to json

        # process input and return result
        return get_daily_DELAs(session, date, service_id, selected_AOSO, employee_ids)

    # catch unexpected error
    except Exception as e:
        return unexpected_error_response(e)
