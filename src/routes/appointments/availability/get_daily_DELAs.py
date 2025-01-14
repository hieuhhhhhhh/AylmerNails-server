from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc
from .helpers.table_to_DELA import table_to_DELA
from datetime import datetime
import pytz


# return list of DELAs for inputted list of employee_ids
def get_daily_DELAs(session, date, service_id, selected_AOSO, employee_ids):
    # result holder
    DELAs = []

    # parse date to day of the week for Toronto timezone
    day_of_week = get_day_of_week_toronto(date)

    # get tables of DELAs or appo_lists
    tables = call_3D_proc(
        "sp_get_DELAs_or_appo_lists",
        session,
        date,
        day_of_week,
        service_id,
        selected_AOSO,
        employee_ids,
    )

    for table in tables:
        # fetch DELA from every table
        DELA = []
        if table[0][0] is not None:
            for row in table:
                record = row[0]
                if record is not None:
                    DELA.append(record)
        else:
            # generate DELA
            DELA = table_to_DELA(table)

        # stack them to result
        DELAs.append(DELA)

    return jsonify({"DELAs": DELAs}), 200


def get_day_of_week_toronto(unix_time):
    # Create a timezone object for Toronto
    toronto_tz = pytz.timezone("America/Toronto")

    # Convert the Unix timestamp to a datetime object
    date_time = datetime.fromtimestamp(unix_time)

    # Apply the Toronto timezone to the datetime object
    date_time_toronto = toronto_tz.localize(date_time)

    # Get the day of the week as an integer (Monday = 0, Sunday = 6)
    day_of_week = date_time_toronto.weekday()

    return day_of_week + 1
