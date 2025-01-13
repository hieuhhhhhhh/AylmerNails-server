from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc
from .helpers.appo_ranges_table_to_DELA import appo_ranges_table_to_DELA
from .helpers.store_DELA import store_DELA


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
                if row[0] is not None:
                    DELA.append(row[0])
            DELAs.append(DELA)
        else:
            # generate DELA
            DELA = appo_ranges_table_to_DELA(table)

            # send DELA to mysql
            store_DELA(DELA)

    return jsonify({"DELAs": DELAs}), 200
