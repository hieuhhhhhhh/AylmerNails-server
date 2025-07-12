from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc


def delete_employee(session, employee_id):
    # call mysql proc to process data
    row_count = call_3D_proc("sp_delete_employee", session, employee_id)[0][0][0]

    if row_count < 1:
        return (
            jsonify(
                {
                    "message": "Employee's availability must end before deleting",
                }
            ),
            400,
        )

    return "deleted", 200
