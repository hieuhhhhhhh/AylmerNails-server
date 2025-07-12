from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc
from src.routes.helpers.normalize_and_define_query import normalize_and_define_query


def search_users(session, query, limit):
    # normalize
    type, query = normalize_and_define_query(query)

    # call mysql proc to process data
    users = call_3D_proc("sp_search_users", session, query, type, limit)[0]

    return (
        jsonify(
            {
                "users": users,
                "user_def": "[[ userId, phoneNumId, phoneNum, role, firstName, lastName, joinedOn, contactName], ]",
            }
        ),
        200,
    )
