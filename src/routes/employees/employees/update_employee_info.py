from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc


def update_service_info(
    session,
    employee_id,
    alias,
    interval_percent,
    last_date,
    color_id,
    service_ids,
):

    # call mysql proc to process data
    call_3D_proc(
        "sp_update_employee_info",
        session,
        employee_id,
        alias,
        interval_percent,
        last_date,
        color_id,
        service_ids,
    )

    return jsonify({"message": "updated succesfully"}), 200
