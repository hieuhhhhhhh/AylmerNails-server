from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc


def get_AOSs(service_id):
    # call mysql proc to process data
    res = call_3D_proc("sp_get_AOSs", service_id)
    service_info = res[0][0]
    add_on_services = res[1]

    return (
        jsonify(
            {
                "service_info": service_info,
                "list_definition": "name, description, duration, price, client_can_book",
                "add_on_services": add_on_services,
                "list_definition": "option_id, option_text, option_offset, aos_id, aos_text",
            }
        ),
        200,
    )
