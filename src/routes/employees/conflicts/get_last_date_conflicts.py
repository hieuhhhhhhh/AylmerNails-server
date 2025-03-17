from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc


def get_last_date_conflicts(emp_id):
    # call mysql proc to process data
    conflicts = call_3D_proc("sp_get_emp_ld_conflicts", emp_id)

    return (
        jsonify(
            {
                "conflicts": conflicts,
                "conflicts_def": "empId, appoId,  appoDate, appoDOW, appoStart, appoEnd, empAlias, serviceName",
            }
        ),
        200,
    )
