from src.mysql.procedures.call_3D_proc import call_3D_proc


def verify_code(phone_number, code):
    # Verify code in db to verify in next request (return a table)
    results = call_3D_proc("sp_verify_code", phone_number, code)

    # read the table:
    success = results[0][0][0]
    msg = results[0][0][1]

    # Return the message and status code as a tuple
    return success, msg
