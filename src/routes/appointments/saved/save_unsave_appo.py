from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc
from src.socketio import emit_saving


def save_unsave_appo(session, appo_id, boolean):
    # call mysql proc to process data
    call_3D_proc("sp_save_unsave_appo", session, appo_id, boolean)
    emit_saving()

    return "request done", 200
