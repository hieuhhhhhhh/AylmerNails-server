from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc
from src.routes.helpers.normalize_and_define_query import normalize_and_define_query


def search_contacts(session, query, limit):
    # normalize
    type, query = normalize_and_define_query(query)

    # call mysql proc to process data
    contacts = call_3D_proc("sp_search_contacts", session, query, type, limit)[0]

    return (
        jsonify(
            {
                "contacts": contacts,
                "contacts_def": "[[phoneNum, contactId, name, time, firstName, lastName], ]",
            }
        ),
        200,
    )
