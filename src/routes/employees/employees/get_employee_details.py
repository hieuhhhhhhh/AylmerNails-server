from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc


def get_employee_details(emp_id):
    # call mysql proc to process data
    emp_info = call_3D_proc("sp_get_employee_details", emp_id)[0][0]

    return (
        jsonify(
            {
                "emp_info": emp_info,
                "list_definition": "employee_id, alias, stored_intervals, last_date",
            }
        ),
        200,
    )
