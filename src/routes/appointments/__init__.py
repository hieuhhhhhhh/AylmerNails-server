import json
from flask import Blueprint, request
from ..helpers.default_error_response import default_error_response
from src.routes.authentication.session.read_token import read_token

from .availability.get_availability_list import get_availability_list
from .availability.write_daily_note import write_daily_note
from .availability.get_daily_note import get_daily_note

from .appos.client_add_appo import client_add_appo
from .appos.guest_add_appo import guest_add_appo
from .appos.admin_add_appo import admin_add_appo
from .appos.get_daily_appos import get_daily_appos
from .appos.get_appo_length import get_appo_length
from .appos.get_appo_details import get_appo_details
from .appos.update_appo import update_appo
from .appos.write_appo_note import write_appo_note

from .delete_appo.admin_remove_appo import admin_remove_appo
from .delete_appo.cancel_appo import cancel_appo

from .contacts.search_contacts import search_contacts
from .contacts.update_contact import update_contact

from .notifications.search_bookings import search_bookings
from .notifications.get_bookings_last_tracked import get_bookings_last_tracked
from .notifications.search_canceled_appos import search_canceled_appos
from .notifications.get_canceled_last_tracked import get_canceled_last_tracked

from .saved.search_saved_appos import search_saved_appos
from .saved.get_saved_last_tracked import get_saved_last_tracked
from .saved.save_unsave_appo import save_unsave_appo
from .saved.unsave_all_appos import unsave_all_appos


# create blueprint (group of routes)
appointments = Blueprint("appointments", __name__)


@appointments.route("/client_add_appo", methods=["POST"])
def client_add_appo_():
    try:
        # read token
        session = read_token()

        # read json from request
        data = request.get_json()
        slots = data.get("slots")
        date = data.get("date")

        # process input and return result
        return client_add_appo(session, slots, date)

    # catch unexpected error
    except Exception as e:
        return default_error_response(e)


@appointments.route("/guest_add_appo", methods=["POST"])
def guest_add_appo_():
    try:
        # read json from request
        data = request.get_json()
        otp_id = data.get("otp_id")
        otp = data.get("otp")
        slots = data.get("slots")
        date = data.get("date")
        name = data.get("name")

        # process input and return result
        return guest_add_appo(otp_id, otp, slots, date, name)

    # catch unexpected error
    except Exception as e:
        return default_error_response(e)


@appointments.route("/admin_add_appo", methods=["POST"])
def admin_add_appo_():
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
        return admin_add_appo(
            session, phone_num, name, emp_id, service_id, AOSOs, date, start, end, note
        )

    # catch unexpected error
    except Exception as e:
        return default_error_response(e)


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
        message = data.get("message")
        selected_emps = json.dumps(data.get("selected_emps"))
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
            selected_emps,
            message,
            note,
        )

    # catch unexpected error
    except Exception as e:
        return default_error_response(e)


@appointments.route("/search_contacts/<query>", methods=["GET"])
def search_contacts_(query):
    try:
        # read token
        session = read_token()

        # process input and return result
        return search_contacts(session, query)

    # catch unexpected error
    except Exception as e:
        return default_error_response(e)


@appointments.route("/search_contacts", methods=["GET"])
def search_contacts_no_query():
    try:
        # read token
        session = read_token()

        # process input and return result
        return search_contacts(session, "")

    # catch unexpected error
    except Exception as e:
        return default_error_response(e)


@appointments.route("/update_contact", methods=["POST"])
def update_contact_():
    try:
        # read token
        session = read_token()

        # read json
        data = request.get_json()
        phone_num = data.get("phoneNum")
        name = data.get("name")

        # process input and return result
        return update_contact(session, phone_num, name)

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


@appointments.route("/search_bookings", methods=["POST"])
def search_bookings_():
    try:
        # read token
        session = read_token()

        # read json
        data = request.get_json()
        query = data.get("query")
        limit = data.get("limit")

        # process input and return result
        return search_bookings(session, query, limit)

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
        # read token
        session = read_token()

        # read json
        data = request.get_json()
        query = data.get("query")
        limit = data.get("limit")

        # process input and return result
        return search_canceled_appos(session, query, limit)

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


@appointments.route("/search_saved_appointments", methods=["POST"])
def search_saved_appointments():
    try:
        # read json
        data = request.get_json()
        query = data.get("query")
        limit = data.get("limit")

        # process input and return result
        return search_saved_appos(query, limit)

    # catch unexpected error
    except Exception as e:
        return default_error_response(e)


@appointments.route("/get_saved_last_tracked", methods=["GET"])
def get_saved_last_tracked_():
    try:
        # read token
        session = read_token()

        # process input and return result
        return get_saved_last_tracked(session)

    # catch unexpected error
    except Exception as e:
        return default_error_response(e)


@appointments.route("/save_unsave_appo", methods=["POST"])
def save_unsave_appo_():
    try:
        # read token
        session = read_token()

        # read json from request
        data = request.get_json()
        appo_id = data.get("appo_id")
        boolean = data.get("boolean")

        # process input and return result
        return save_unsave_appo(session, appo_id, boolean)

    # catch unexpected error
    except Exception as e:
        return default_error_response(e)


@appointments.route("/unsave_all_appointments", methods=["POST"])
def unsave_all_appointments():
    try:
        # read token
        session = read_token()

        # process input and return result
        return unsave_all_appos(session)

    # catch unexpected error
    except Exception as e:
        return default_error_response(e)


@appointments.route("/write_appointment_note", methods=["POST"])
def write_appointment_note():
    try:
        # read token
        session = read_token()

        # read json from request
        data = request.get_json()
        appo_id = data.get("appo_id")
        note = data.get("note")

        # process input and return result
        return write_appo_note(session, appo_id, note)

    # catch unexpected error
    except Exception as e:
        return default_error_response(e)


@appointments.route("/write_daily_note", methods=["POST"])
def write_daily_note_():
    try:
        # read token
        session = read_token()

        # read json from request
        data = request.get_json()
        date = data.get("date")
        note = data.get("note")

        # process input and return result
        return write_daily_note(session, date, note)

    # catch unexpected error
    except Exception as e:
        return default_error_response(e)


@appointments.route("/get_daily_note/<date>", methods=["GET"])
def get_daily_note_(date):
    try:
        # read token
        session = read_token()

        # process input and return result
        return get_daily_note(session, date)

    # catch unexpected error
    except Exception as e:
        return default_error_response(e)
