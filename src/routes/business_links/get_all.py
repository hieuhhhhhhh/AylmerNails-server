from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc


def get_all():
    # call mysql proc to process data
    links = call_3D_proc("sp_get_business_links")[0]

    return (
        jsonify(
            {
                "links": links,
                "def": "[[link_id, name, value],]",
            }
        ),
        200,
    )
