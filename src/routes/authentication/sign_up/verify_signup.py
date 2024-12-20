from ..sms_verification.sp_verify_code import verify_code
from flask import jsonify
from ..new_auth.sp_new_auth import create_new_auth


def verify_signup(phone_num, code):
    print("\033[94m" + "verify_new_password" + "\033[0m")

    # check if verification code is correct
    success, msg = verify_code(phone_num, code)

    # create new authentication if successful verification
    if success:
        create_new_auth(phone_num)

    # prepare response status
    status = 200 if success else 400

    return jsonify({"message": msg}), status
