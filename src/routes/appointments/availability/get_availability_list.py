from flask import jsonify
import json
from .get_daily_DELAs import get_daily_DELAs


def get_availability_list(DELAs_requests):
    # results holder
    results = []

    # iterate every request
    for req in DELAs_requests:
        service_id = req.get("service_id")
        employee_ids = req.get("employee_ids")
        date = req.get("date")
        selected_AOSO = req.get("selected_AOSO")

        # fetch and stack result
        res = get_daily_DELAs(date, service_id, selected_AOSO, employee_ids)
        results.append(res)

    return (
        jsonify(
            {"DELAs_list": results, "list_def": "[[{employee_id, length, slots},]"}
        ),
        200,
    )
