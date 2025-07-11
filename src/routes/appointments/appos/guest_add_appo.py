import json
from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc
from src.mysql.procedures.multi_call_3D_proc import multi_call_3D_proc
from src.routes.helpers.get_day_of_week_toronto import get_day_of_week_toronto
from src.socketio import emit_booking
from mysql.connector import Error


def guest_add_appo(otp_id, otp, slots, date, name):
    # params holder
    param_list = []

    # result holder
    appo_ids = []
    phone_num = ""
    client_name = ""

    # fetch day of week
    day_of_week = get_day_of_week_toronto(date + 12 * 60 * 60)

    # validate session and get contacts
    res = call_3D_proc("sp_validate_guest_booking", otp_id, name)
    true_otp, phone_num_id = res[0][0]
    if true_otp is None:
        return jsonify({"message": "Code has expired, please request a new one"}), 400
    if true_otp != otp:
        return jsonify({"message": "Incorrect code, please try again"}), 400

    # parse slots to procedure params
    booker_id = None
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
            phone_num_id,
            booker_id,
            empId,
            serviceId,
            AOSOs,
            date,
            day_of_week,
            start,
            selected_emps,
            message,
        ]
        param_list.append(params)

    # list of locking tables
    tables = [
        "durations",
        "services",
        "AOS_options ao",
        "add_on_services aos",
        "DELAs",
        "DELA_slots",
        "appo_details",
        "appo_employees",
        "contacts c",
        "phone_numbers p",
        "appo_notifications",
        "authentication",
    ]

    # start calling procedure
    try:
        res = multi_call_3D_proc("sp_add_appo_by_DELA", tables, param_list)
    except Error as e:
        if e.errno == 1644:
            return (
                jsonify({"message": e.msg}),
                400,
            )

    # read result
    for table in res:
        appo_id = table[0][0][0]
        client_name = table[0][0][1]
        phone_num = table[0][0][2]

        appo_ids.append(appo_id)
    # clean up otp code
    call_3D_proc(
        "sp_remove_otp_code",
        otp_id,
    )

    # push notification to some clients
    emit_booking()

    # return result
    return (
        jsonify(
            {
                "added_appo_ids": appo_ids,
                "phone_num": phone_num,
                "client_name": client_name,
            }
        ),
        200,
    )
