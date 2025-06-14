import json
from flask import jsonify
from src.mysql.procedures.multi_call_3D_proc import multi_call_3D_proc
from src.routes.helpers.get_day_of_week_toronto import get_day_of_week_toronto
from src.socketio import emit_booking


def guest_add_appo(session, slots, date):
    # params holder
    paramsList = []
    # result holder
    appo_ids = []

    # fetch day of week
    day_of_week = get_day_of_week_toronto(date + 12 * 60 * 60)

    # parse slots to procedure params
    for slot in slots:
        # unpack every slot
        empId = slot.get("empId")
        serviceId = slot.get("serviceId")
        AOSOs = json.dumps(slot.get("AOSOs"))
        start = slot.get("start")
        selected_emps = json.dumps(slot.get("empIds"))
        message = slot.get("message")

        # create, append param list
        params = [
            session,
            empId,
            serviceId,
            AOSOs,
            date,
            day_of_week,
            start,
            selected_emps,
            message,
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
        "appo_employees",
        "appo_notifications",
    ]

    # start calling procedure
    res = multi_call_3D_proc("sp_add_appo_by_DELA", tables, paramsList)

    # read result
    for table in res:
        appo_id = table[0][0][0]
        appo_ids.append(appo_id)

    # push notification to some clients
    emit_booking()

    # return result
    return jsonify({"added_appo_ids": appo_ids}), 200
