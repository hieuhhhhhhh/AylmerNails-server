from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc


def get_AOSs(service_id):
    # call mysql proc to process data
    add_on_services = call_3D_proc("sp_get_AOSs", service_id)[0]

    return (
        jsonify(
            {
                "add_on_services": add_on_services,
                "list_definition": "option_id, option_text, option_offset, aos_id, aos_text",
            }
        ),
        200,
    )
