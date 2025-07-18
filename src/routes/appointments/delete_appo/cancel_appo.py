from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc
from src.socketio import emit_canceling


def cancel_appo(session, appo_id):
    # call mysql proc to process data
    call_3D_proc("sp_cancel_appo", session, appo_id)

    # push notification
    emit_canceling()

    return "canceled successfully", 200
