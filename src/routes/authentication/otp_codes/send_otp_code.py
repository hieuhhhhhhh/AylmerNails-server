from flask import current_app
from twilio.rest import Client


def send_otp_code(code, phone_num):
    # env variables
    TWILIO_SID = current_app.config["TWILIO_SID"]
    TWILIO_TOKEN = current_app.config["TWILIO_TOKEN"]
    BUSINESS_PHONE = current_app.config["BUSINESS_PHONE"]

    # init
    client = Client(TWILIO_SID, TWILIO_TOKEN)

    # write message
    msg_body = f"Aylmer Nails & Spa (no-reply inbox),\nYour verification code: {code} "

    # call api
    client.messages.create(
        body=msg_body,
        from_=BUSINESS_PHONE,
        to=phone_num,
    )
