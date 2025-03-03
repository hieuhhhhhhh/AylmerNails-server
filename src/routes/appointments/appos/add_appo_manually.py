from flask import jsonify
from src.mysql.procedures.call_3D_proc_with_lock import call_3D_proc_with_lock


def add_appo_manually(session, employee_id, service_id, AOSOs, date, start, end, note):
    # locking tables
    tables = [
        "user_sessions us",
        "authentication a",
        "appo_details",
        "opening_hours oh",
        "schedules s",
    ]

    # call mysql proc to process data
    res = call_3D_proc_with_lock(
        "sp_add_appo_manually",
        tables,
        session,
        employee_id,
        service_id,
        AOSOs,
        date,
        start,
        end,
        note,
    )[0][0][0]

    overlap = res[0]
    if overlap[0] is not None:
        ov_start = overlap[1]
        ov_end = overlap[2]
        return jsonify({"error_type": 1, "start": ov_start, "end": ov_end}), 400

    conflict_schedule = res[1]
    if conflict_schedule[0] is not None:
        day_start = conflict_schedule[0]
        day_end = conflict_schedule[1]
        return jsonify({"error_type": 2, "start": day_start, "end": day_end}), 400

    appo_id = res[2]
    return jsonify({"added_appo_id": appo_id}), 200
