from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc


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

    # call mysql proc to process data
    call_3D_proc(
        "sp_update_service_info",
        session,
        service_id,
        name,
        description,
        category_id,
        last_date,
        price,
        client_can_book,
    )

    return jsonify({"message": "updated succesfully"}), 200
