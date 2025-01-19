from flask import jsonify
from src.mysql.procedures.call_2D_proc import call_2D_proc


def search_services(query):
    # call mysql proc to process data
    services = call_2D_proc("sp_search_services", query)

    return (
        jsonify(
            {
                "found_services": services,
                "list_definition": "service_id",
            }
        ),
        200,
    )
