import re
from flask import jsonify
from ..otp_codes.request_otp_code import request_otp_code
from src.mysql.procedures.call_3D_proc import call_3D_proc


def request_forgot_password(phone_num):
    # validate phone number
    phonenum_is_available = call_3D_proc("sp_is_phonenum_avail", phone_num)[0][0][0]

    if phonenum_is_available:
        return jsonify({"message": "Number is not linked to any account"}), 400

    # if valid, proceed
    return request_otp_code(phone_num)
