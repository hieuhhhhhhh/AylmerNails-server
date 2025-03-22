from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc


def update_user_role(query):
    # call mysql proc to process data
    contacts = call_3D_proc("sp_search_contacts", query)[0]

    return (
        jsonify(
            {
                "contacts": contacts,
                "contacts_def": "[[phoneNum, contactId, name, time], ]",
            }
        ),
        200,
    )
