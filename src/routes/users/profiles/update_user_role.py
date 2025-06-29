from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc


def update_user_role(session, user_id, role):
    # call mysql proc to process data
    call_3D_proc("sp_update_user_role", session, user_id, role)

    return "updated successfully", 200
