from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc


def get_notifications(session, limit):
    # call mysql proc to process data
    [notifications, last_tracked] = call_3D_proc(
        "sp_get_appo_notifications", session, limit
    )

    return (
        jsonify(
            {
                "notifications": notifications,
                "last_tracked": last_tracked,
                "notifications_def": "[[], ]",
            }
        ),
        200,
    )
