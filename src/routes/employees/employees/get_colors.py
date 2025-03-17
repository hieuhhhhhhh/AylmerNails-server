from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc


def get_colors():
    # call mysql proc to process data
    colors = call_3D_proc("sp_get_colors")[0]

    return (
        jsonify(
            {
                "colors": colors,
                "list_definition": "colorId, name, code",
            }
        ),
        200,
    )
