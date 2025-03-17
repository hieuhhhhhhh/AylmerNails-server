from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc


def get_appo_length(
    service_id,
    employee_id,
    AOSOs,
):

    # call mysql proc to process data
    length = call_3D_proc(
        "sp_get_appo_duration",
        service_id,
        employee_id,
        AOSOs,
    )[0][
        0
    ][0]

    return jsonify({"length": length}), 200
