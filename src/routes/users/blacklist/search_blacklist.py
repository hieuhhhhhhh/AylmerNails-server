from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc


def search_blacklist(session, query, limit):
    # call mysql proc to process data
    appos = call_3D_proc("sp_search_blacklist", session, query, limit)[0]

    return (
        jsonify(
            {
                "appos": appos,
                "def": "[[phoneNum, bannedOn, firstName, lastName, contactName], ]",
            }
        ),
        200,
    )
