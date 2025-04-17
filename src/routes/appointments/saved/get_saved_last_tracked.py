from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc


def get_saved_last_tracked(session):

    # call mysql proc to process data
    last_tracked = call_3D_proc("sp_get_saved_last_tracked", session)[0][0][0]

    return (
        jsonify(
            {
                "last_tracked": last_tracked,
            }
        ),
        200,
    )
