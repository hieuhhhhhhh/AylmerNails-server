from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc


def get_service_details(service_id):
    # call mysql proc to process data
    res = call_3D_proc("sp_get_service_details", service_id)

    # parse and return data
    service_info = res[0]
    service_lengths = res[1:]

    return (
        jsonify(
            {
                "service_info": service_info,
                "service_info_def": "[service_id, name, description, last_date, cate_id, cate_name]",
                "service_lengths": service_lengths,
                "service_lengths_def": "[effective_from, length],[employee_id, alias, length_offset]",
            }
        ),
        200,
    )
