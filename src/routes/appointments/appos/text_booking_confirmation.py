from flask import current_app
from twilio.rest import Client
from src.mysql.procedures.call_3D_proc import call_3D_proc
from datetime import timedelta, datetime
import pytz


def text_booking_confirmation(phone_num, appo_ids):
    # env variables
    TWILIO_SID = current_app.config["TWILIO_SID"]
    TWILIO_TOKEN = current_app.config["TWILIO_TOKEN"]
    BUSINESS_PHONE = current_app.config["BUSINESS_PHONE"]

    # init
    client = Client(TWILIO_SID, TWILIO_TOKEN)

    # fetch details from db
    appos_msg = ""
    date_msg = ""
    for appo_id in appo_ids:
        date, start, end, service = call_3D_proc("sp_get_appo_info", appo_id)[0][0]
        appos_msg += f"{seconds_to_am_pm(start)} - {seconds_to_am_pm(end)}: {service}\n"
        date_msg = unix_to_toronto_long_date(date)

    # write message
    msg_body = f"Aylmer Nails & Spa (no-reply inbox),\n Appointment on {date_msg}:\n {appos_msg}  "

    # call api
    client.messages.create(
        body=msg_body,
        from_=BUSINESS_PHONE,
        to=phone_num,
    )


def unix_to_toronto_long_date(unix_timestamp):
    tz_toronto = pytz.timezone("America/Toronto")
    dt = datetime.fromtimestamp(unix_timestamp, tz_toronto)
    return dt.strftime("%A, %B %d, %Y")


def seconds_to_am_pm(seconds):
    base_time = datetime.strptime("00:00", "%H:%M")
    new_time = base_time + timedelta(seconds=seconds)
    return new_time.strftime("%I:%M %p")
