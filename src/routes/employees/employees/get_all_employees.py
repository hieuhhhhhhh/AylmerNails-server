from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc


def get_all_employees():
    # call mysql proc to process data
    employees = call_3D_proc("sp_get_all_employees")[0]

    return (
        jsonify(
            {
                "all_employees": employees,
                "list_definition": "employee_id, alias, first_date, last_date",
            }
        ),
        200,
    )
