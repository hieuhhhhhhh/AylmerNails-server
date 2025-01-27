from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc
from .tokenize_service_name import tokenize_service_name


def update_service_info(session, service_id, name, description, category_id, last_date):
    # tokenize the name of the new service
    sn_tokens = tokenize_service_name(name)

    # call mysql proc to process data
    call_3D_proc(
        "sp_update_service_info",
        session,
        service_id,
        name,
        sn_tokens,
        description,
        category_id,
        last_date,
    )

    return jsonify({"message": "updated succesfully"}), 200
