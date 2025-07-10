from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc


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
    # call mysql proc to process data
    service_id = call_3D_proc(
        "sp_add_service",
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
    )[0][0][0]

    return jsonify({"added_service_id": service_id}), 200
