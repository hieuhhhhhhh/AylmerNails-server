from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc


def get_service_employees(service_id, date):
    # call mysql proc to process data
    services = call_3D_proc("sp_get_SEs", service_id, date)[0]

    return (
        jsonify(
            {
                "employees": services,
                "list_definition": " employee_id, alias, last_date, service_id",
            }
        ),
        200,
    )
