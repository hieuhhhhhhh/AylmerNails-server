from flask import jsonify
from src.mysql.procedures.call_2D_proc import call_2D_proc


def add_service(name, category_id, AOSs):
    # call mysql proc to process data
    service_id = call_2D_proc("sp_add_service", name, category_id, AOSs)[0]

    return jsonify({"added_service_id": service_id}), 200
