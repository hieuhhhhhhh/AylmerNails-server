from flask import request
from src.mysql.procedures.call_3D_proc_with_lock import call_3D_proc_with_lock


def is_otp_ready():
    # get ip address
    if request.headers.getlist("X-Forwarded-For"):
        raw_ip = request.headers.getlist("X-Forwarded-For")[0]
    else:
        raw_ip = request.remote_addr
    print(raw_ip)

    # fetch wait values
    locked_tables = [
        "otp_rate_limits",
    ]

    wait_until, next_wait_until, now = call_3D_proc_with_lock(
        "sp_get_otp_rate_limit", locked_tables, raw_ip
    )[0][0]

    # if it is ready, return true
    if wait_until > now:
        return False, wait_until - now
    else:
        return True, next_wait_until - now
