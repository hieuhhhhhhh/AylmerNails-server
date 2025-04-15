from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc
from src.socketio import emit_saving


def unsave_all_appos(session):
    # call mysql proc to process data
    call_3D_proc("sp_unsave_all_appos", session)
    emit_saving()

    return "request done", 200
