import json
from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc


def add_service(
    session, name, category_id, description, date, length, AOSs, employee_ids
):
    # tokenize the name of the new service
    sn_tokens = tokenize_service_name(name)

    # call mysql proc to process data
    service_id = call_3D_proc(
        "sp_add_service",
        session,
        name,
        sn_tokens,
        category_id,
        description,
        date,
        length,
        AOSs,
        employee_ids,
    )[0][0][0]

    return jsonify({"added_service_id": service_id}), 200


def tokenize_service_name(name):
    tokens = name.lower().split()
    return json.dumps(tokens)
