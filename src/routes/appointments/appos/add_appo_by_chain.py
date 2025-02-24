import json
from flask import jsonify
from src.mysql.procedures.multi_call_3D_proc import multi_call_3D_proc


def add_appo_by_chain(session, slots, date):
    # params holder
    paramsList = []
    # result holder
    appo_ids = []
    print(slots)

    # parse slots to procedure params
    for slot in slots:
        # unpack every slot
        start = slot.get("start")
        empId = slot.get("empId")
        serviceId = slot.get("serviceId")
        AOSOs = slot.get("AOSOs")
        params = [session, empId, serviceId, json.dumps(AOSOs), date, start]
        paramsList.append(params)

    # start calling procedure
    res = multi_call_3D_proc("sp_add_appo_by_DELA", paramsList)

    # read result
    for table in res:
        appo_id = table[0][0][0]
        appo_ids.append(appo_id)

    # return result
    return jsonify({"added_appo_ids": appo_ids}), 200
