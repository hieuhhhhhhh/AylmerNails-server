from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc


def get_daily_appos(session, date):
    # call mysql proc to process data
    appos = call_3D_proc(
        "sp_get_daily_appos",
        session,
        date,
    )[0]

    return (
        jsonify(
            {
                "appos": appos,
                "list_def": "[{appoId, empId, serviceId, AOSOs, date, start, end, empAlias, colorCode},]",
            }
        ),
        200,
    )
