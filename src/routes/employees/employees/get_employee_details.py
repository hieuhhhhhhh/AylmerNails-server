from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc


def get_employee_details(emp_id):
    # call mysql proc to process data
    res = call_3D_proc("sp_get_employee_details", emp_id)
    emp_info = res[0][0]
    ld_conflicts = res[1][0][0]
    schedule_conflicts = res[2][0][0]

    return (
        jsonify(
            {
                "emp_info": emp_info,
                "list_definition": "employee_id, alias, colorId, colorName, colorCode, stored_intervals, interval_percent, last_date",
                "ld_conflicts": ld_conflicts,
                "schedule_conflicts": schedule_conflicts,
                "sc_def": "[[scheduleId, conflictCount], ]",
            }
        ),
        200,
    )
