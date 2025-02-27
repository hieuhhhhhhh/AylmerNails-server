from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc


def get_employees(date):
    # call mysql proc to process data
    employees = call_3D_proc("sp_get_employees", date)[0]

    return (
        jsonify(
            {
                "all_employees": employees,
                "list_definition": "employee_id, alias, last_date, is_active, color",
            }
        ),
        200,
    )
