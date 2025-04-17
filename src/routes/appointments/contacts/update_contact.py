from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc
from src.routes.helpers.tokenize_name import tokenize_name


def update_contact(session, phone_num, name):
    # tokenize names
    tokens = tokenize_name(name)

    # call mysql proc to process data
    contactId = call_3D_proc(
        "sp_admin_update_contact", session, phone_num, name, tokens
    )[0]

    return jsonify({"contactId": contactId}), 200
