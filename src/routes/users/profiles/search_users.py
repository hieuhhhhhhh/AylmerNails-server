from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc


def search_users(query, limit):
    # call mysql proc to process data
    users = call_3D_proc("sp_search_users", query, limit)[0]

    return (
        jsonify(
            {
                "users": users,
                "user_def": "[[ userId, phoneNumId, phoneNum, role, firstName, lastName, joinedOn, contactName], ]",
            }
        ),
        200,
    )
