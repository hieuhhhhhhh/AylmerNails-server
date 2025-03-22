from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc


def get_my_profile(session):
    # call mysql proc to process data
    res = call_3D_proc("sp_get_my_profile", session)
    info = res[0]
    appos = res[1]

    return (
        jsonify(
            {
                "info": info,
                "appos": appos,
                "info_def": "[role, birth, phoneNum, firstName, lastName, notes, contactName]",
                "appos_def": "[[empId, empAlias, color, serviceId, serviceName, category, date, start, end], ]",
            }
        ),
        200,
    )
