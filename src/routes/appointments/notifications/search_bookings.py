from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc


def search_bookings(query, limit):
    # call mysql proc to process data
    appos = call_3D_proc("sp_search_bookings", query, limit)[0]

    return (
        jsonify(
            {
                "appos": appos,
                "def": "[[appoId, bookedTime, empId, empAlias, color, serviceId, serviceName, category, phoneNumId, phoneNum, firstName, lastName, date, start, end], ]",
            }
        ),
        200,
    )
