from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc


def update_contact(session, phone_num, name):

    # call mysql proc to process data
    contactId = call_3D_proc("sp_admin_update_contact", session, phone_num, name)[0]

    return jsonify({"contactId": contactId}), 200
