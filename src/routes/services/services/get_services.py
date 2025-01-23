from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc


def get_services(date):
    # call mysql proc to process data
    services = call_3D_proc("sp_get_services", date)[0]

    return (
        jsonify(
            {
                "all_services": services,
                "list_definition": "service_id, service_name, service_last_date, category_id, category_name",
            }
        ),
        200,
    )
