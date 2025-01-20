from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc


def add_schedule(session, employee_id, effective_from, opening_times, closing_times):
    # call mysql proc to process data
    schedule_id = call_3D_proc(
        "sp_add_schedule",
        session,
        employee_id,
        effective_from,
        opening_times,
        closing_times,
    )[0][0][0]

    return jsonify({"added_schedule_id": schedule_id}), 200
