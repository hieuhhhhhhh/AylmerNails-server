from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc
from src.routes.helpers.normalize_and_define_query import normalize_and_define_query


def search_canceled_appos(session, query, limit):
    # normalize
    type, query = normalize_and_define_query(query)

    # call mysql proc to process data
    appos = call_3D_proc("sp_search_canceled_appos", session, query, type, limit)[0]

    return (
        jsonify(
            {
                "appos": appos,
                "def": "[[cancelId, userId, details, time, contactName, profileName, phoneNum], ]",
            }
        ),
        200,
    )
