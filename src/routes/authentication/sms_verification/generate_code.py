from flask import jsonify, current_app
from twilio.rest import Client
import random
from src.mysql.procedures.call_2D_proc import call_2D_proc

# Init lifetime of code (in sec)
CODE_EXPIRY = 300
ATTEMPTS_COUNT = 3


def generate_code(phone_number, new_password=None):
    try:
        # get env variables
        TWILIO_SID = current_app.config["TWILIO_SID"]
        TWILIO_TOKEN = current_app.config["TWILIO_TOKEN"]
        BUSINESS_PHONE = current_app.config["BUSINESS_PHONE"]

        # Initialize the Twilio client
        client = Client(TWILIO_SID, TWILIO_TOKEN)

        # generate and store code in db
        code = random.randint(100, 999)

        # write a message to send client code
        msg_body = f"Your verification code: {code}\n- Aylmer Nails & Spa -"

        # Send a message
        client.messages.create(
            body=msg_body,
            from_=BUSINESS_PHONE,
            to=phone_number,
        )

        # Store code in db to verify in the second request
        call_2D_proc(
            "sp_store_code",
            phone_number,
            new_password,
            code,
            ATTEMPTS_COUNT,
            CODE_EXPIRY,
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
