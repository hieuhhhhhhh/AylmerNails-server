from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc


def add_contact(session, phone_num, name):
    # call mysql proc to process data
    contact_id = call_3D_proc("sp_add_contact", session, phone_num, name)

    return (
        jsonify(
            {
                "contact_id": contact_id,
            }
        ),
        200,
    )
