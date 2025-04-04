from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc


def get_canceled_appos(session, limit):
    # call mysql proc to process data
    res = call_3D_proc("sp_get_canceled_appos", session, limit)
    appos = res[0]
    last_tracked = res[1][0][0]

    return (
        jsonify(
            {
                "appos": appos,
                "last_tracked": last_tracked,
                "appos_def": "[[cancelId, userId, details, time, firstName, lastName, phoneNum], ]",
            }
        ),
        200,
    )
