from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc


def get_daily_note(session, date):
    # call mysql proc to process data
    note = call_3D_proc("sp_get_daily_note", session, date)[0][0][0]

    return jsonify({"note": note}), 200
