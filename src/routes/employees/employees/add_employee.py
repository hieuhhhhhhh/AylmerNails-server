import json
from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc


def add_employee(
    session, alias, key_intervals, interval_percent, color_id, service_ids
):

    # generate stored intervals
    stored_intervals = generate_stored_intervals(key_intervals, 24 * 60 * 60)

    # call mysql proc to process data
    employee_id = call_3D_proc(
        "sp_add_employee",
        session,
        alias,
        stored_intervals,
        interval_percent,
        color_id,
        service_ids,
    )[0][0][0]

    return jsonify({"added_employee_id": employee_id}), 200


def generate_stored_intervals(key_intervals, threshold):
    # result holder
    interval_set = set()

    # fetch 2 keys
    key1 = key_intervals[0]
    key2 = key_intervals[1]

    if key1 < 300 or key2 < 300:
        raise Exception("keys are too small (less than 5 mins)")

    # generate stored intervals with formula x*key1 + y*key2 <= threshold
    # x and y are integers that increment from 0,1,2, .etc
    max_x = threshold // key1
    for x in range(0, max_x):
        max_y = (threshold - key1 * x) // key2
        for y in range(0, max_y):
            interval = x * key1 + y * key2
            interval_set.add(interval)

    # convert to required data type (a sorted json array)
    return json.dumps(sorted(interval_set))
