import random
from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc
from .send_otp_code import send_otp_code


def request_otp_code(phone_num):
    # generate code
    code = random.randint(1000, 9999)

    try:
        # send otp code by sms
        send_otp_code(code, phone_num)
    except:
        return (jsonify({"message": "Invalid phone number"}), 400)

    # add code to db
    code_id = call_3D_proc("sp_add_otp_code", phone_num, code, 3, 60 * 5)[0][0][0]

    # return code id
    return (jsonify({"code_id": code_id}), 200)
