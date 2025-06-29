import bcrypt  # Import bcrypt for password hashing
from flask import jsonify
from src.mysql.procedures.call_3D_proc import call_3D_proc


def change_password(session, password, new_password):
    # validate current password
    db_password = call_3D_proc("sp_get_password_by_session", session)[0][0][0]
    if not bcrypt.checkpw(password.encode("utf-8"), db_password.encode("utf-8")):
        return (
            jsonify({"message": "Current password does not match"}),
            400,
        )

    #  validate new password
    if password == new_password:
        return (
            jsonify({"message": "New password must be different"}),
            400,
        )
    if len(new_password) < 6:
        return (
            jsonify({"message": "New password must be at least 6 characters long"}),
            400,
        )

    # encrypt passwords
    new_password = bcrypt.hashpw(new_password.encode("utf-8"), bcrypt.gensalt()).decode(
        "utf-8"
    )

    # validate phone number
    call_3D_proc("sp_change_password", session, new_password)

    return "Password updated", 200
