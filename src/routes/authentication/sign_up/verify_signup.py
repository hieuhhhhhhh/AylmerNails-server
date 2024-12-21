from ..sms_verification.verify_code import verify_code
from flask import jsonify


def verify_signup(phone_num, code):
    print("\033[94m" + "verify_new_password" + "\033[0m")

    # check if verification code is correct
    success, msg = verify_code(phone_num, code)

    # prepare response status
    status = 201 if success else 400

    return jsonify({"message": msg}), status
