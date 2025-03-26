from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc


def admin_remove_appo(session, appo_id):
    # call mysql proc to process data
    call_3D_proc("sp_admin_remove_appo", session, appo_id)

    return "deleted", 200
