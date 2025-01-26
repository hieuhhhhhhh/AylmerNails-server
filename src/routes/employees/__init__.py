import json
from flask import Blueprint, request
from src.routes.authentication.session.read_token import read_token
from ..helpers.default_error_response import default_error_response
from src.routes.employees.employees.add_employee import add_employee
from src.routes.employees.employees.set_employee_last_date import set_employee_last_date
from src.routes.employees.schedules.add_schedule import add_schedule
from src.routes.employees.employees.get_employees import get_employees
from src.routes.employees.employees.get_ESs import get_employee_services

# create blueprint (group of routes)
employees = Blueprint("employees", __name__)


@employees.route("/get_employees/<date>", methods=["GET"])
def get_employees_(date):
    try:
        # return employee list with some basic information
        return get_employees(date)
    # catch unexpected error
    except Exception as e:
        return default_error_response(e)


@employees.route("/add_employee", methods=["POST"])
def add_employee_():
    try:
        # read token
        session = read_token()

        # read json from request
        data = request.get_json()
        alias = data.get("alias")
        key_intervals = data.get("key_intervals")
        service_ids = json.dumps(data.get("service_ids"))  # convert python list to json

        return add_employee(session, alias, key_intervals, service_ids)

    # catch unexpected error
    except Exception as e:
        return default_error_response(e)


@employees.route("/set_employee_last_date", methods=["POST"])
def set_employee_last_date_():
    try:
        # read token
        session = read_token()

        # read json from request
        data = request.get_json()
        employee_id = data.get("employee_id")
        last_date = data.get("last_date")

        return set_employee_last_date(session, employee_id, last_date)

    # catch unexpected error
    except Exception as e:
        return default_error_response(e)


@employees.route("/add_schedule", methods=["POST"])
def add_schedule_():
    try:
        # read token
        session = read_token()

        # read json from request
        data = request.get_json()
        employee_id = data.get("employee_id")
        effective_from = data.get("effective_from")

        opening_times = json.dumps(
            data.get("opening_times")
        )  # convert python list to json

        closing_times = json.dumps(
            data.get("closing_times")
        )  # convert python list to json

        return add_schedule(
            session, employee_id, effective_from, opening_times, closing_times
        )

    # catch unexpected error
    except Exception as e:
        return default_error_response(e)


@employees.route("/get_employee_services/<int:emp_id>/<date>", methods=["GET"])
def get_employee_services_(emp_id, date):
    try:
        return get_employee_services(emp_id, date)
    # catch unexpected error
    except Exception as e:
        return default_error_response(e)
