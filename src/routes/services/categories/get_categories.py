from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc


def get_categories():
    # call mysql proc to process data
    categoriess = call_3D_proc("sp_get_categories")[0]

    return (
        jsonify(
            {
                "categories": categoriess,
                "list_definition": "cate_id, name",
            }
        ),
        200,
    )
