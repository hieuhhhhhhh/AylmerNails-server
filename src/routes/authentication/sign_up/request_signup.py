from flask import jsonify
import bcrypt  # Import bcrypt for password hashing
from .sp_is_phonenum_avail import phonenum_is_avail
from ..sms_verification.sp_store_code import send_code_by_sms


def request_signup(phone_num, password):
    print("\033[94m" + "process_credentials_input" + "\033[0m")

    # Check if phone number or password is missing
    if not (phone_num and password):
        return (
            jsonify({"message": "No phone number or password provided"}),
            400,
        )  # Bad Request

    # Validate password length (at least 6 characters)
    if len(password) < 6:
        return (
            jsonify({"message": "Password must be at least 6 characters long"}),
            400,
        )  # Bad Request

    # check if phonenumber has been used
    if not phonenum_is_avail(phone_num):
        return (
            jsonify({"message": "This phone number has already been used"}),
            400,
        )  # Bad Request

    # Hash the password before storing it
    hashed = bcrypt.hashpw(password.encode("utf-8"), bcrypt.gensalt()).decode("utf-8")

    # generate and send a verification code to phone num
    return send_code_by_sms(phone_num, hashed)
