from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc


def update_user_role(session, user_id, role):
    # call mysql proc to process data
    try:
        call_3D_proc("sp_update_user_role", session, user_id, role)
    except Exception as e:
        status = e.msg[:3]

        if status == "400":
            return jsonify({"message": "Can not change role of owners"}), 403

        return jsonify({"message": "Only owners can change a user's role"}), 403

    return "updated successfully", 200
