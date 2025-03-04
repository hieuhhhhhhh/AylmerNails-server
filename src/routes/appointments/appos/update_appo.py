from flask import jsonify
from src.mysql.procedures.call_3D_proc_with_lock import call_3D_proc_with_lock
from src.routes.helpers.get_day_of_week_toronto import get_day_of_week_toronto


def update_appo(session, appo_id, emp_id, service_id, AOSOs, date, start, end, note):
    # locking tables
    tables = [
        "user_sessions us",
        "authentication a",
        "appo_details",
        "opening_hours oh",
        "schedules s",
    ]

    # parse date to day of the week for Toronto timezone (add half a day to shift to mid-day timestamp)
    day_of_week = get_day_of_week_toronto(int(date) + 12 * 60 * 60)

    # call mysql proc to process data
    res = call_3D_proc_with_lock(
        "sp_update_appo",
        tables,
        session,
        appo_id,
        emp_id,
        service_id,
        AOSOs,
        date,
        day_of_week,
        start,
        end,
        note,
    )

    overlap = res[0][0]
    if overlap[0] is not None:
        ov_start = overlap[1]
        ov_end = overlap[2]
        return (
            jsonify(
                {
                    "error_type": 1,
                    "start": ov_start,
                    "end": ov_end,
                    "message": "overlaping another appointment",
                }
            ),
            400,
        )

    conflict_schedule = res[1][0]
    if conflict_schedule[0] is not None:
        day_start = conflict_schedule[1]
        day_end = conflict_schedule[2]
        return (
            jsonify(
                {
                    "error_type": 2,
                    "start": day_start,
                    "end": day_end,
                    "message": "not match schedule",
                }
            ),
            400,
        )

    appo_id = res[2][0]
    return jsonify({"appo_id": appo_id}), 200
