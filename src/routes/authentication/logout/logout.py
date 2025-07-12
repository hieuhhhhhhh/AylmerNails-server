import json
from src.mysql.procedures.call_3D_proc import call_3D_proc
from flask import make_response


def logout(session):
    # fetch the session id
    session_id = json.loads(session)["id"]

    # update database
    call_3D_proc(
        "sp_log_out",
        session_id,
    )

    # create response
    body = "log out successfully"
    status = 200

    response = make_response(body, status)

    # make response delete cookie on client
    response.delete_cookie("TOKEN", samesite="None", secure=True)

    return response
