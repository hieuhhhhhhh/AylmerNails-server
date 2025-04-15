from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc


def search_saved_appos(query, limit):
    # call mysql proc to process data
    appos = call_3D_proc("sp_search_saved_appos", query, limit)[0]

    return (
        jsonify(
            {
                "appos": appos,
                "def": "[[appoId, savedOn, empId, empAlias, color, serviceId, serviceName, category, phoneNumId, phoneNum, contactName, date, start, end], ]",
            }
        ),
        200,
    )
