from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc


def get_employee_services(employee_id, date):
    # call mysql proc to process data
    [services, categories] = call_3D_proc("sp_get_ESs", employee_id, date)

    return (
        jsonify(
            {
                "services": services,
                "services_def": "service_id, service_name, category_id, employee_id",
                "categories": categories,
                "categories_def": "cate_id, cate_name",
            }
        ),
        200,
    )
