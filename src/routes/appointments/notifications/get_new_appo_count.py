from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc


def get_new_appo_count(session):
    # call mysql proc to process data
    count = call_3D_proc("sp_get_new_appo_count", session)[0][0][0]

    return jsonify({"count": count}), 200
