from flask import jsonify
from src.mysql.procedures.call_2D_proc import call_2D_proc


def add_employee(session, alias, first_date, key_intervals, service_ids):
    # call mysql proc to process data
    employee_id = call_2D_proc(
        "sp_add_employee", session, alias, first_date, key_intervals, service_ids
    )[0][0]

    return jsonify({"added_employee_id": employee_id}), 200
