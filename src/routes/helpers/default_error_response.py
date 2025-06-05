from flask import jsonify
import traceback


def default_error_response(exception):
    print(traceback.format_exc())
    if hasattr(exception, "msg"):
        status = exception.msg[:3]

        if status == "401":
            return (
                jsonify(
                    {
                        "error": str(exception),
                        "details": traceback.format_exc(),
                        "message": "Access denied, please check your account privileges or log in again.",
                    }
                ),
                status,
            )

        if status.isdigit():
            return (
                jsonify(
                    {
                        "error": str(exception),
                        "details": traceback.format_exc(),
                        "message": exception.msg,
                    }
                ),
                status,
            )

    return (
        jsonify(
            {
                "error": str(exception),
                "details": traceback.format_exc(),
                "message": "Request denied, an unknown error occurred",
            }
        ),
        500,  # internal server error status
    )
