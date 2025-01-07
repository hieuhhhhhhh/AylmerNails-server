from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc
from .helpers.appo_list_table_to_DELA import appo_list_table_to_DELA


# return list of DELAs for inputted list of employee_ids
def get_daily_DELAs(session, date, service_id, selected_AOSO, employee_ids):
    # result holder
    DELAs = []

    # get tables of DELAs or appo_lists
    tables = call_3D_proc(
        "sp_get_DELAs_or_appo_lists",
        session,
        date,
        service_id,
        selected_AOSO,
        employee_ids,
    )

    for table in tables:
        if table[0][0] is not None:
            for row in table[0]:
                DELA = []
                DELA.append(row[0])
            DELAs.append(DELA)
        else:
            DELA = appo_list_table_to_DELA(table)

    return jsonify({"DELAs": DELAs}), 200
