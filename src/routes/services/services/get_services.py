from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc


def get_services(date):
    # call mysql proc to process data
    [services, categories] = call_3D_proc("sp_get_services", date)

    return (
        jsonify(
            {
                "services": services,
                "services_def": "service_id, service_name, last_date, is_active, category_id, price",
                "categories": categories,
                "categories_def": "cate_id, cate_name, sort_order",
            }
        ),
        200,
    )
