from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc


def get_service_details(service_id):
    # call mysql proc to process data
    res = call_3D_proc("sp_get_service_details", service_id)

    # parse and return data
    info = res[0][0]
    durations = res[1]
    AOSs = res[2]

    return (
        jsonify(
            {
                "info": info,
                "info_def": "[service_id, name, description, first_date, last_date, duration, cate_id, cate_name]",
                "durations": durations,
                "durations_def": "[[emp_id, alias, duration],]",
                "AOSs": AOSs,
                "AOSs_def": "[answer_id, answer, offset, question_id, question]",
            }
        ),
        200,
    )
