from flask import jsonify
from twilio.rest import Client
import random


def send_code_by_sms(phone_number):
    try:
        twilio_sid = "AC29bb3bbf530c66dcee6f1c200bbf8bf0"
        twilio_token = "55a1d9b921ed0ec3f2bb73482a2ae9aa"

        # Initialize the Twilio client
        client = Client(twilio_sid, twilio_token)

        # generate and store code in db
        code = random.randint(100, 999)

        # write a message to send client code
        msg_body = f"Your verification code: {code}\n- Aylmer Nails & Spa -"

        # Send a message
        client.messages.create(
            body=msg_body,
            from_="+17824823111",
            to=phone_number,
        )
        return (
            jsonify({"message": f"Code sent to :{phone_number}"}),
            200,
        )
    except Exception as e:
        # prepare default message:
        msg = "An error occurred, please try different phone number"

        if "Twilio" in str(e):
            msg = f"The phone number is invalid: {phone_number}"

        # return code 500 Internal Server Error
        return jsonify({"error": str(e), "message": msg}), 500
