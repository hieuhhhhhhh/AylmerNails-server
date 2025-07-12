import json
from flask import Blueprint, request
from src.routes.authentication.session.read_token import read_token
from ..helpers.default_error_response import default_error_response
from src.routes.employees.schedules.add_schedule import add_schedule

from src.routes.employees.employees.add_employee import add_employee
from src.routes.employees.employees.get_employees import get_employees
from src.routes.employees.employees.get_ESs import get_employee_services
from src.routes.employees.employees.get_employee_details import get_employee_details
from src.routes.employees.employees.update_employee_info import update_service_info
from src.routes.employees.employees.delete_employee import delete_employee

from src.routes.employees.schedules.get_employee_schedules import get_employee_schedules
from src.routes.employees.employees.get_colors import get_colors
from src.routes.employees.conflicts.get_last_date_conflicts import (
    get_last_date_conflicts,
)
from src.routes.employees.conflicts.get_schedule_conflicts import get_schedule_conflicts


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
        interval_percent = data.get("interval_percent")
        color_id = data.get("color_id")
        service_ids = json.dumps(data.get("service_ids"))  # convert python list to json

        return add_employee(
            session, alias, key_intervals, interval_percent, color_id, service_ids
        )

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


@employees.route("/get_employee_details/<int:emp_id>", methods=["GET"])
def get_employee_details_(emp_id):
    try:
        # read token
        session = read_token()

        return get_employee_details(session, emp_id)
    # catch unexpected error
    except Exception as e:
        return default_error_response(e)


@employees.route("/get_employee_schedules/<int:emp_id>", methods=["GET"])
def get_employee_schedules_(emp_id):
    try:
        return get_employee_schedules(emp_id)
    # catch unexpected error
    except Exception as e:
        return default_error_response(e)


@employees.route("/update_employee_info", methods=["POST"])
def update_employee_info_():
    try:
        # read token
        session = read_token()

        # read json from request
        data = request.get_json()
        employee_id = data.get("employee_id")
        alias = data.get("alias")
        interval_percent = data.get("interval_percent")
        last_date = data.get("last_date")
        color_id = data.get("color_id")
        service_ids = json.dumps(data.get("service_ids"))

        return update_service_info(
            session,
            employee_id,
            alias,
            interval_percent,
            last_date,
            color_id,
            service_ids,
        )
    # catch unexpected error
    except Exception as e:
        return default_error_response(e)


@employees.route("/get_colors", methods=["GET"])
def get_colors_():
    try:
        return get_colors()
    # catch unexpected error
    except Exception as e:
        return default_error_response(e)


@employees.route("/get_schedule_conflicts/<emp_id>", methods=["GET"])
def get_schedule_conflicts_(emp_id):
    try:
        return get_schedule_conflicts(emp_id)
    # catch unexpected error
    except Exception as e:
        return default_error_response(e)


@employees.route("/get_employee_ld_conflicts/<emp_id>", methods=["GET"])
def get_employee_ld_conflicts(emp_id):
    try:
        return get_last_date_conflicts(emp_id)
    # catch unexpected error
    except Exception as e:
        return default_error_response(e)


@employees.route("/delete_employee", methods=["POST"])
def delete_employee_():
    try:
        # read token:
        session = read_token()
        # read json from request
        data = request.get_json()
        emp_id = data.get("emp_id")

        return delete_employee(session, emp_id)
    # catch unexpected error
    except Exception as e:
        return default_error_response(e)
