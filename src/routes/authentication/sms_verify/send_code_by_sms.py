from twilio.rest import Client


def send_code_by_sms():
    twilio_sid = "AC29bb3bbf530c66dcee6f1c200bbf8bf0"
    twilio_token = "55a1d9b921ed0ec3f2bb73482a2ae9aa"

    # Initialize the Twilio client
    client = Client(twilio_sid, twilio_token)

    # Send a message
    client.messages.create(
        body="Hello, this is a test message from Twilio!",
        from_="+17824823111",
        to="+12269851917",
    )
