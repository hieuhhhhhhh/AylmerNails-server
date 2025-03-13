from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc


def remove_appo(
    session,
    appo_id,
):

    # call mysql proc to process data
    call_3D_proc(
        "sp_remove_appo",
        session,
        appo_id,
    )

    return jsonify({"message": "appointment removed"}), 200
