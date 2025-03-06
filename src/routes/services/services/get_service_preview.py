from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc


def get_service_preview(service_id, date):
    # call mysql proc to process data
    preview = call_3D_proc("sp_get_service_preview", service_id, date)[0][0]

    return (
        jsonify(
            {
                "preview": preview,
                "list_definition": "service_id, name, description, last_date, cate_id, cate_name, duration",
            }
        ),
        200,
    )
