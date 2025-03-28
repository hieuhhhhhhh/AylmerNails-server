from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc


def get_notifications(session, limit):
    # call mysql proc to process data
    res = call_3D_proc("sp_get_appo_notifications", session, limit)
    appos = res[0]
    last_tracked = res[1]

    return (
        jsonify(
            {
                "appos": appos,
                "last_tracked": last_tracked,
                "notifications_def": "[[appoId, bookedTime, empId, empAlias, color, serviceId, serviceName, category, phoneNumId, phoneNum, contactName, date, start, end], ]",
            }
        ),
        200,
    )
