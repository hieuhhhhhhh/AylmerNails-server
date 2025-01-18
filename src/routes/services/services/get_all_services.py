from flask import jsonify
from src.mysql.procedures.call_2D_proc import call_2D_proc


def get_all_services():
    # call mysql proc to process data
    services = call_2D_proc("sp_get_all_services")

    return (
        jsonify(
            {
                "all_services": services,
                "list_definition": "service_id, service_name, service_last_date, category_id, category_name",
            }
        ),
        200,
    )
