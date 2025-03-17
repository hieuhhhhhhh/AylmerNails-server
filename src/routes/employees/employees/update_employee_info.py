from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc
from src.routes.helpers.tokenize_name import tokenize_name


def update_service_info(
    session,
    employee_id,
    alias,
    interval_percent,
    last_date,
    color_id,
    service_ids,
):
    # tokenize the name of the new employee
    alias_tokens = tokenize_name(alias)

    # call mysql proc to process data
    call_3D_proc(
        "sp_update_employee_info",
        session,
        employee_id,
        alias,
        alias_tokens,
        interval_percent,
        last_date,
        color_id,
        service_ids,
    )

    return jsonify({"message": "updated succesfully"}), 200
