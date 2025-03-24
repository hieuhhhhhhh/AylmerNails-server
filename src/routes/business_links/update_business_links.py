from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc


def update_business_links():
    # call mysql proc to process data
    call_3D_proc("sp_update_business_links")[0]

    return "updated successfully", 200
