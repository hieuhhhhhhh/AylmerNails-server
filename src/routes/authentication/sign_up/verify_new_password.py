from ..sms_verification.sp_verify_code import verify_code
from flask import jsonify


def verify_new_password(phone_num, code):
    print("\033[94m" + "verify_new_password" + "\033[0m")

    # check if verification code is correct
    success, msg = verify_code(phone_num, code)
