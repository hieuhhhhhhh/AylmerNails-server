import json
from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc


def update_business_links(session, phone_num, address, instagram, email):
    # parse payload
    links = []
    links.append("phone_number")
    links.append(phone_num)
    links.append("google_map")
    links.append(address)
    links.append("instagram")
    links.append(instagram)
    links.append("email")
    links.append(email)

    # call mysql proc to process data
    call_3D_proc("sp_update_business_links", session, json.dumps(links))

    return "updated successfully", 200
