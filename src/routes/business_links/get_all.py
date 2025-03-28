from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc


def get_all():
    # call mysql proc to process data
    links = call_3D_proc("sp_get_business_links")[0]
    phone_num = links[0][1]
    address = links[1][1]
    instagram = links[2][1]
    email = links[3][1]

    return (
        jsonify(
            {
                "phoneNum": phone_num,
                "address": address,
                "instagram": instagram,
                "email": email,
            }
        ),
        200,
    )
