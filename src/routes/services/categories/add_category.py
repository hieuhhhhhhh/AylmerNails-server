from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc


def add_category(session, name):
    # call mysql proc to process data
    category_id = call_3D_proc("sp_add_category", session, name)[0][0][0]

    return jsonify({"added_category_id": category_id}), 200
