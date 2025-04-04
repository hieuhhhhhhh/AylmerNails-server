from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc


def get_users(session, limit):
    # call mysql proc to process data
    res = call_3D_proc("sp_get_users", session, limit)
    users = res[0]
    last_tracked = res[1][0][0]

    return (
        jsonify(
            {
                "users": users,
                "last_tracked": last_tracked,
                "user_def": "[[ userId, phoneNumId, phoneNum, role, firstName, lastName, joinedOn, contactName], ]",
            }
        ),
        200,
    )
