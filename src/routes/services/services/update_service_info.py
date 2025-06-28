from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc
from src.routes.helpers.tokenize_name import tokenize_name


def update_service_info(
    session,
    service_id,
    name,
    description,
    category_id,
    last_date,
    price,
    client_can_book,
):
    # tokenize the name of the new service
    sn_tokens = tokenize_name(name)

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
        price,
        client_can_book,
    )

    return jsonify({"message": "updated succesfully"}), 200
