import json
from flask import jsonify
from src.mysql.procedures.multi_call_3D_proc import multi_call_3D_proc
from src.routes.helpers.get_day_of_week_toronto import get_day_of_week_toronto


def add_appo_by_chain(session, slots, date):
    # params holder
    paramsList = []
    # result holder
    appo_ids = []

    # fetch day of week
    day_of_week = get_day_of_week_toronto(date + 12 * 60 * 60)

    # parse slots to procedure params
    for slot in slots:
        # unpack every slot
        start = slot.get("start")
        empId = slot.get("empId")
        serviceId = slot.get("serviceId")
        AOSOs = slot.get("AOSOs")

        # create, append param list
        params = [
            session,
            empId,
            serviceId,
            json.dumps(AOSOs),
            date,
            day_of_week,
            start,
        ]
        paramsList.append(params)

    # list of locking tables
    tables = [
        "user_sessions us",
        "unconfirmed_salts",
        "authentication a",
        "durations",
        "services",
        "AOS_options ao",
        "add_on_services aos",
        "DELAs",
        "DELA_slots",
        "appo_details",
    ]

    # start calling procedure
    res = multi_call_3D_proc("sp_add_appo_by_DELA", tables, paramsList)

    # read result
    for table in res:
        appo_id = table[0][0][0]
        appo_ids.append(appo_id)

    # return result
    return jsonify({"added_appo_ids": appo_ids}), 200
