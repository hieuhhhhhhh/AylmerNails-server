from src.mysql.procedures.call_3D_proc import call_3D_proc
from src.socketio import emit_banning


def ban_unban_phone_num(session, phone_num, boolean):
    # call mysql proc to process data
    call_3D_proc("sp_ban_unban_phone_num", session, phone_num, boolean)
    emit_banning()

    return "request done", 200
