from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc


def get_ES_ids(service_id, date):
    # call mysql proc to process data
    service_ids = []
    table = call_3D_proc("sp_get_ESs", service_id, date)[0]
    for row in table:
        service_ids.append(row[0])

    return (
        jsonify(
            {
                "service_ids": service_ids,
                "list_definition": " service_id, name, last_date",
            }
        ),
        200,
    )
