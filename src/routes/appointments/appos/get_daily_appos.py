from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc
from datetime import datetime
import pytz


def get_daily_appos(session, date):
    # parse date to day of the week for Toronto timezone (add half a day to shift to mid-day timestamp)
    day_of_week = get_day_of_week_toronto(int(date) + 12 * 60 * 60)

    # call mysql proc to process data
    res = call_3D_proc("sp_get_daily_appos", session, date, day_of_week)

    appos = res[0]
    employees = res[1]

    return (
        jsonify(
            {
                "appos": appos,
                "appos_def": "[{appoId, empId, serviceId, AOSOs, date, start, end},]",
                "employees": employees,
                "emp_def": "[{empId, alias, colorId, colorCode, openTime, closeTime, dayOfWeek, scheduleId, effectiveFrom},]",
            }
        ),
        200,
    )


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
