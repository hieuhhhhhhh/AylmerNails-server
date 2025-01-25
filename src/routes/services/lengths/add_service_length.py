from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc


def add_service_length(session, service_id, effective_from, length, SLVs):
    # call mysql proc to process data
    service_length_id = call_3D_proc(
        "sp_add_service_length", session, service_id, effective_from, length, SLVs
    )[0][0][0]

    return jsonify({"added_service_length_id": service_length_id}), 200
