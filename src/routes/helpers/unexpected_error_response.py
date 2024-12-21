from flask import jsonify
import traceback


def unexpected_error_response(exception):
    print(traceback.format_exc())
    return (
        jsonify(
            {
                "error": str(exception),
                "details": traceback.format_exc(),
                "message": "An unknown error occurred",
            }
        ),
        500,  # internal server error status
    )
