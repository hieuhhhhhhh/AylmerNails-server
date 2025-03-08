from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc


def get_duration_conflicts(service_id):
    # call mysql proc to process data
    conflicts = call_3D_proc("sp_get_duration_conflicts", service_id)

    return (
        jsonify(
            {
                "conflicts": conflicts,
                "conflicts_def": "serviceId, appoId,  appoDate, appoDOW, appoStart, appoEnd, empAlias, serviceName",
            }
        ),
        200,
    )
