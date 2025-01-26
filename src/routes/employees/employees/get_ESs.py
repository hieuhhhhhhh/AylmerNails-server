from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc


def get_employee_services(service_id, date):
    # call mysql proc to process data
    services = call_3D_proc("sp_get_ESs", service_id, date)[0]

    return (
        jsonify(
            {
                "services": services,
                "list_definition": " service_id, name, last_date",
            }
        ),
        200,
    )
