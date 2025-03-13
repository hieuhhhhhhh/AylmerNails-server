from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc


def search_contacts(phone_num):
    # call mysql proc to process data
    contacts = call_3D_proc("sp_search_contacts", phone_num)

    return (
        jsonify(
            {
                "contacts": contacts,
                "contacts_def": "[[contactId, phoneNum, name, time], ]",
            }
        ),
        200,
    )
