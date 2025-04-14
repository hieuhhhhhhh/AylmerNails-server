from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc


def save_unsave_appo(session, appo_id, boolean):
    # call mysql proc to process data
    call_3D_proc("sp_save_unsave_appo", session, appo_id, boolean)

    return "request done", 200
