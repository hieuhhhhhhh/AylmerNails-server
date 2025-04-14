from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc


def ban_unban_phone_num(session, phone_num, boolean):
    # call mysql proc to process data
    call_3D_proc("sp_ban_unban_phone_num", session, phone_num, boolean)

    return "request done", 200
