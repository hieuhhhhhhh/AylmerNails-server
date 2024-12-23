from flask import make_response


def response_with_token(body, status, token):
    response = make_response(body, status)
    response.set_cookie("TOKEN", token)

    return response
