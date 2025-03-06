from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc


def update_durations(session, service_id, default_duration, durations):
    # call mysql proc to process data
    call_3D_proc(
        "sp_update_durations", session, service_id, default_duration, durations
    )

    return jsonify({"message": "update done"}), 200
