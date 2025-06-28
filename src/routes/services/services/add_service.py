from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc
from src.routes.helpers.tokenize_name import tokenize_name


def add_service(
    session,
    name,
    category_id,
    description,
    date,
    duration,
    AOSs,
    employee_ids,
    price,
    client_can_book,
):
    # tokenize the name of the new service
    sn_tokens = tokenize_name(name)

    # call mysql proc to process data
    service_id = call_3D_proc(
        "sp_add_service",
        session,
        name,
        sn_tokens,
        category_id,
        description,
        date,
        duration,
        AOSs,
        employee_ids,
        price,
        client_can_book,
    )[0][0][0]

    return jsonify({"added_service_id": service_id}), 200
