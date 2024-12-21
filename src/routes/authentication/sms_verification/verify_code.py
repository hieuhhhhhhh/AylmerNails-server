from src.mysql.call_sp import call_sp

# Init lifetime of code (in sec)
CODE_LIFETIME = 300


def verify_code(phone_number, code):
    # Verify code in db to verify in next request (return a table)
    results = call_sp("sp_verify_code", phone_number, code, CODE_LIFETIME)

    # read the table:
    success = results[0][0]
    msg = results[0][1]

    # Return the message and status code as a tuple
    return success, msg
