from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc


def get_user_details(session, user_id):
    # call mysql proc to process data
    call_3D_proc("sp_validate_admin", session)
    res = call_3D_proc("sp_get_user_details", user_id)

    info = res[0][0]
    appos = res[1]

    return (
        jsonify(
            {
                "info": info,
                "appos": appos,
                "info_def": "[role, birth, phoneNum, firstName, lastName, notes, contactName, bannedOn]",
                "appos_def": "[[appoId, empId, empAlias, color, serviceId, serviceName, category, date, start, end], ]",
            }
        ),
        200,
    )
