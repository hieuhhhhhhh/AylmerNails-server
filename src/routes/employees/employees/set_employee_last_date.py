from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc


def set_employee_last_date(session, employee_id, last_date):
    # call mysql proc to process data
    call_3D_proc("sp_set_ELD", session, employee_id, last_date)

    return jsonify({"message": "updated succesfully"}), 200
