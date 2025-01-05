from flask import Blueprint, request
from src.routes.authentication.session.read_token import read_token
from ..helpers.unexpected_error_response import unexpected_error_response
from src.routes.employees.employees.add_employee import add_employee
from src.routes.employees.employees.set_employee_last_date import set_employee_last_date

# create blueprint (group of routes)
employees = Blueprint("employees", __name__)


@employees.route("/add_employee", methods=["POST"])
def request_sign_up():
    try:
        # read token
        session = read_token()

        # read json from request
        data = request.get_json()
        alias = data.get("alias")
        first_date = data.get("first_date")

        return add_employee(session, alias, first_date)

    # catch unexpected error
    except Exception as e:
        return unexpected_error_response(e)


@employees.route("/set_employee_last_date", methods=["POST"])
def request_sign_up():
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
        return unexpected_error_response(e)
