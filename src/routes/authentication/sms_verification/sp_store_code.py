from flask import jsonify, current_app
from twilio.rest import Client
import random
from src.mysql.execute_sql_file.many_queries import exe_queries
from src.mysql.call_sp import call_sp


# to build the required procedures:
def create_sp_store_code():
    print("\033[94m" + "create_sp_store_code" + "\033[0m")
    exe_queries(__file__, "sp_store_code.sql")


def send_code_by_sms(phone_number, new_password=None):
    try:
        # get env variables
        TWILIO_SID = current_app.config["TWILIO_SID"]
        TWILIO_TOKEN = current_app.config["TWILIO_TOKEN"]

        # Initialize the Twilio client
        client = Client(TWILIO_SID, TWILIO_TOKEN)

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

        # Store code in db to verify in next request
        call_sp("sp_store_code", phone_number, new_password, code, 3)

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
