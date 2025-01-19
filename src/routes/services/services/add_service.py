from flask import jsonify
from src.mysql.procedures.call_2D_proc import call_2D_proc


def add_service(session, name, category_id, AOSs):
    # tokenize the name of the new service
    sn_tokens = tokenize_service_name(name)

    # call mysql proc to process data
    service_id = call_2D_proc(
        "sp_add_service", session, name, category_id, AOSs, sn_tokens
    )[0][0]

    return jsonify({"added_service_id": service_id}), 200


def tokenize_service_name(name):
    words = name.split().lower()
    return words
