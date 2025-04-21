from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc


def get_appo_details(session, appo_id):

    # call mysql proc to process data
    res = call_3D_proc("sp_get_appo_details", session, appo_id)
    appo_details = res[0][0]
    appo_emps = res[1]
    AOSOs = res[2:]

    return (
        jsonify(
            {
                "appo_details": appo_details,
                "list_def": "appoId, empId, serviceId, AOSOs, date, day_of_week, start, end, note, color, empAlias, serviceName, cateName, userId, savedOn",
                "appo_emps": appo_emps,
                "appo_emps_def": "[[empId, empAlias],]",
                "AOSOs": AOSOs,
                "AOSOs_def": "[[AOSid, question, optionId, answer, offset],]",
            }
        ),
        200,
    )
