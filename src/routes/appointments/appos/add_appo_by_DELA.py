from flask import jsonify
from src.mysql.procedures.call_2D_proc import call_2D_proc


def add_appo_by_DELA(session, employee_id, service_id, selected_AOSO, date, start_time):
    # call mysql proc to process data
    appo_id = call_2D_proc(
        "sp_add_appo_by_DELA",
        session,
        employee_id,
        service_id,
        selected_AOSO,
        date,
        start_time,
    )[0][0]

    return jsonify({"added_appo_id": appo_id}), 200
