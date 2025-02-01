import json
from src.mysql.procedures.call_3D_proc import call_3D_proc
from .helpers.table_to_DELA import table_to_DELA
from datetime import datetime
import pytz


# return list of DELAs for inputted list of employee_ids
def get_daily_DELAs(date, service_id, selected_AOSO, employee_ids):
    # result holder
    DELAs = {"service_id": service_id, "values": []}

    # parse date to day of the week for Toronto timezone (add half a day to shift to mid-day timestamp)
    day_of_week = get_day_of_week_toronto(date + 12 * 60 * 60)

    # get tables of DELAs or appo_lists
    tables = call_3D_proc(
        "sp_get_DELAs_or_appo_lists",
        date,
        day_of_week,
        service_id,
        json.dumps(selected_AOSO),
        json.dumps(employee_ids),
    )

    # iterate every table to create DELA
    for i in range(len(tables)):
        table = tables[i]
        # create nested dictionary
        DELA = {"employee_id": employee_ids[i], "length": None, "slots": []}

        if table[0][0] is not None:
            # fetch length
            length = table[0][1]
            DELA["length"] = length

            # fetch slots
            slots = []
            for row in table:
                record = row[0]
                if record is not None:
                    slots.append(record)
            DELA["slots"] = slots

        else:
            # generate DELA
            table_to_DELA(table, DELA)

        # assign employee_id

        # stack them to result
        DELAs["values"].append(DELA)

    return DELAs


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
