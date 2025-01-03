from flask import jsonify
from src.mysql.procedures.call_2D_proc import call_2D_proc


def set_employee_last_date(session, alias, first_date):
    # call mysql proc to process data
    call_2D_proc("sp_set_ELD", session, alias, first_date)

    return jsonify({"message": "updated succesfully"}), 200
