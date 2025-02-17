from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc


def get_appo_length(
    service_id,
    employee_id,
    date,
    AOSOs,
):

    # call mysql proc to process data
    appo_id = call_3D_proc(
        "sp_get_appo_length",
        service_id,
        employee_id,
        date,
        AOSOs,
    )[0]

    return jsonify({"length": appo_id}), 200
