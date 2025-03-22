from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc


def update_my_profile(session, first_name, last_name):
    # call mysql proc to process data
    call_3D_proc("sp_update_my_profile", session, first_name, last_name)
    return "updated succesfully", 200
