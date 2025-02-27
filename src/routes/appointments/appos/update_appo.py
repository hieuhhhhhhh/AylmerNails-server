from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc


def update_appo(session, appo_id, emp_id, service_id, AOSOs, date, start, end, note):

    # call mysql proc to process data
    appo_id = call_3D_proc(
        "sp_update_appo",
        appo_id,
        emp_id,
        service_id,
        AOSOs,
        date,
        start,
        end,
        note,
    )[0][0][0]

    return jsonify({"appo_id": appo_id}), 200
