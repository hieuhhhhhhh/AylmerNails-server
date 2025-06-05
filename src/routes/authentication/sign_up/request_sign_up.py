import re
from flask import jsonify
from ..otp_codes.request_code import request_otp_code
from src.mysql.procedures.call_3D_proc import call_3D_proc


def request_sign_up(phone_num, first_name, last_name):
    # validate names
    first_name = first_name.strip()
    last_name = last_name.strip()
    name_pattern = re.compile(r"^[A-Za-z]+(?: [A-Za-z]+)*$")

    if not name_pattern.match(first_name) or not name_pattern.match(last_name):
        return (
            jsonify({"message": "Invalid name: only letters or spaces are allowed"}),
            400,
        )

    # validate phone number
    phone_is_avail = call_3D_proc("sp_is_phonenum_avail", phone_num)[0][0][0]

    if not phone_is_avail:
        return jsonify({"message": "Number already registered"}), 400

    # if valid, proceed
    return request_otp_code(phone_num)
