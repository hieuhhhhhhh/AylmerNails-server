import json
from flask import Blueprint, request
from ..helpers.default_error_response import default_error_response
from src.routes.authentication.session.read_token import read_token
from .availability.get_availability_list import get_availability_list

from .appos.add_appo_by_chain import add_appo_by_chain
from .appos.get_daily_appos import get_daily_appos
from .appos.get_appo_length import get_appo_length
from .appos.get_appo_details import get_appo_details
from .appos.update_appo import update_appo
from .appos.add_appo_manually import add_appo_manually

from .delete_appo.admin_remove_appo import admin_remove_appo
from .delete_appo.cancel_appo import cancel_appo


from .contacts.search_contacts import search_contacts

from .notifications.get_notifications import get_notifications
from .notifications.get_canceled_appos import get_canceled_appos
from .notifications.search_bookings import search_bookings
from .notifications.get_bookings_last_tracked import get_bookings_last_tracked
from .notifications.search_canceled_appos import search_canceled_appos
from .notifications.get_canceled_last_tracked import get_canceled_last_tracked


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


@appointments.route("/get_appo_length", methods=["POST"])
def get_appo_length_():
    try:
        # read json from request
        data = request.get_json()
        service_id = data.get("service_id")
        employee_id = data.get("employee_id")
        AOSOs = json.dumps(data.get("AOSOs"))

        # process input and return result
        return get_appo_length(
            service_id,
            employee_id,
            AOSOs,
        )

    # catch unexpected error
    except Exception as e:
        return default_error_response(e)


@appointments.route("/get_appo_details/<appo_id>", methods=["GET"])
def get_appo_details_(appo_id):
    try:
        # read token
        session = read_token()

        # process input and return result
        return get_appo_details(
            session,
            appo_id,
        )

    # catch unexpected error
    except Exception as e:
        return default_error_response(e)


@appointments.route("/update_appointment", methods=["POST"])
def update_appointment():
    try:
        # read token
        session = read_token()

        # read json
        data = request.get_json()
        appo_id = data.get("appo_id")
        phone_num = data.get("phone_num")
        name = data.get("name")
        emp_id = data.get("emp_id")
        service_id = data.get("service_id")
        AOSOs = json.dumps(data.get("AOSOs"))
        date = data.get("date")
        start = data.get("start")
        end = data.get("end")
        note = data.get("note")

        # process input and return result
        return update_appo(
            session,
            appo_id,
            phone_num,
            name,
            emp_id,
            service_id,
            AOSOs,
            date,
            start,
            end,
            note,
        )

    # catch unexpected error
    except Exception as e:
        return default_error_response(e)


@appointments.route("/add_appointment_manually", methods=["POST"])
def add_appointment_manually_():
    try:
        # read token
        session = read_token()

        # read json
        data = request.get_json()
        phone_num = data.get("phone_num")
        name = data.get("name")
        emp_id = data.get("emp_id")
        service_id = data.get("service_id")
        AOSOs = json.dumps(data.get("AOSOs"))
        date = data.get("date")
        start = data.get("start")
        end = data.get("end")
        note = data.get("note")

        # process input and return result
        return add_appo_manually(
            session, phone_num, name, emp_id, service_id, AOSOs, date, start, end, note
        )

    # catch unexpected error
    except Exception as e:
        return default_error_response(e)


@appointments.route("/search_contacts/<query>", methods=["GET"])
def search_contacts_(query):
    try:
        # process input and return result
        return search_contacts(query)

    # catch unexpected error
    except Exception as e:
        return default_error_response(e)


@appointments.route("/search_contacts", methods=["GET"])
def search_contacts_no_query():
    try:
        # process input and return result
        return search_contacts("")

    # catch unexpected error
    except Exception as e:
        return default_error_response(e)


@appointments.route("/admin_remove_appointment", methods=["POST"])
def admin_remove_appointment():
    try:
        # read token
        session = read_token()

        # read json
        data = request.get_json()
        appo_id = data.get("appo_id")

        # process input and return result
        return admin_remove_appo(session, appo_id)

    # catch unexpected error
    except Exception as e:
        return default_error_response(e)


@appointments.route("/cancel_appointment", methods=["POST"])
def cancel_appointment():
    try:
        # read token
        session = read_token()

        # read json
        data = request.get_json()
        appo_id = data.get("appo_id")

        # process input and return result
        return cancel_appo(session, appo_id)

    # catch unexpected error
    except Exception as e:
        return default_error_response(e)


@appointments.route("/get_notifications/<limit>", methods=["GET"])
def get_notifications_(limit):
    try:
        # read token
        session = read_token()

        # process input and return result
        return get_notifications(session, limit)

    # catch unexpected error
    except Exception as e:
        return default_error_response(e)


@appointments.route("/get_canceled_appointments/<limit>", methods=["GET"])
def get_canceled_appointments(limit):
    try:
        # read token
        session = read_token()

        # process input and return result
        return get_canceled_appos(session, limit)

    # catch unexpected error
    except Exception as e:
        return default_error_response(e)


@appointments.route("/search_bookings", methods=["POST"])
def search_bookings_():
    try:
        # read json
        data = request.get_json()
        query = data.get("query")
        limit = data.get("limit")

        # process input and return result
        return search_bookings(query, limit)

    # catch unexpected error
    except Exception as e:
        return default_error_response(e)


@appointments.route("/get_last_tracked", methods=["GET"])
def get_last_tracked():
    try:
        # read token
        session = read_token()

        # process input and return result
        return get_bookings_last_tracked(session)

    # catch unexpected error
    except Exception as e:
        return default_error_response(e)


@appointments.route("/search_canceled_appointments", methods=["POST"])
def search_canceled_appointments():
    try:
        # read json
        data = request.get_json()
        query = data.get("query")
        limit = data.get("limit")

        # process input and return result
        return search_canceled_appos(query, limit)

    # catch unexpected error
    except Exception as e:
        return default_error_response(e)


@appointments.route("/get_canceled_last_tracked", methods=["GET"])
def get_canceled_last_tracked_():
    try:
        # read token
        session = read_token()

        # process input and return result
        return get_canceled_last_tracked(session)

    # catch unexpected error
    except Exception as e:
        return default_error_response(e)
