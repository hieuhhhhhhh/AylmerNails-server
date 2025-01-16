from flask import jsonify
from src.mysql.procedures.call_2D_proc import call_2D_proc


def get_all_employees():
    # call mysql proc to process data
    employees = call_2D_proc("sp_set_ELD")

    return jsonify({"all_employees": employees}), 200
