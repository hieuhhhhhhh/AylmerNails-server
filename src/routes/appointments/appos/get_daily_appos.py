from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc
from src.routes.helpers.get_day_of_week_toronto import get_day_of_week_toronto


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
                "appos_def": "[{appoId, empId, serviceId, AOSOs, date, start, end, serviceName},]",
                "employees": employees,
                "emp_def": "[{empId, alias, colorId, colorCode, openTime, closeTime, dayOfWeek, scheduleId, effectiveFrom},]",
            }
        ),
        200,
    )
