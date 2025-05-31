from flask import jsonify
from ..otp_codes.request_code import request_otp_code
from src.mysql.procedures.call_3D_proc import call_3D_proc


def request_sign_up(phone_num):
    # validate phone number
    phone_is_avail = call_3D_proc("sp_is_phonenum_avail", phone_num)[0][0][0]

    if not phone_is_avail:
        return (jsonify({"message": "Number already registered"}), 400)

    # if valid, proceed
    return request_otp_code(phone_num)
