from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc


def get_employee_schedules(employee_id):
    # call mysql proc to process data
    schedules = call_3D_proc(
        "sp_get_employee_schedules",
        employee_id,
    )[0]

    return (
        jsonify(
            {
                "schedules": schedules,
                "list_def": "day_of_week,opening_time,closing_time,schedule_id,effective_from",
            }
        ),
        200,
    )
