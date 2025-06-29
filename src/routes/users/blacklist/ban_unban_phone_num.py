from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc
from src.socketio import emit_banning


def ban_unban_phone_num(session, phone_num, boolean):
    # call mysql proc to process data
    try:
        call_3D_proc("sp_ban_unban_phone_num", session, phone_num, boolean)
    except Exception:
        return jsonify({"message": "Not allowed to ban admin accounts"}), 400

    # push notifications
    emit_banning()

    # reply request
    return "request done", 200
