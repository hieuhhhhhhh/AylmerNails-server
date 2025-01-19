import json
from flask import Blueprint, request
from ..helpers.unexpected_error_response import unexpected_error_response
from src.routes.authentication.session.read_token import read_token
from .services.add_service import add_service
from .lengths.add_service_length import add_service_length
from .services.get_many_services import get_many_services
from .services.search_services import search_services

# create blueprint (group of routes)
services = Blueprint("services", __name__)


@services.route("/get_many_services/<timestamp>", methods=["GET"])
def get_many_services_(timestamp):
    try:
        # return service list
        return get_many_services(timestamp)
    # catch unexpected error
    except Exception as e:
        return unexpected_error_response(e)


@services.route("/add_service", methods=["POST"])
def add_service_():
    try:
        # read token
        session = read_token()

        # read json from request
        data = request.get_json()
        name = data.get("name")
        category_id = data.get("category_id")
        AOSs = json.dumps(data.get("AOSs"))  # convert python list to json

        return add_service(session, name, category_id, AOSs)

    # catch unexpected error
    except Exception as e:
        return unexpected_error_response(e)


@services.route("/add_service_length", methods=["POST"])
def add_service_length_():
    try:
        # read token
        session = read_token()

        # read json from request
        data = request.get_json()
        service_id = data.get("service_id")
        effective_from = data.get("effective_from")
        length = data.get("length")
        SLVs = json.dumps(data.get("SLVs"))  # convert python list to json

        return add_service_length(session, service_id, effective_from, length, SLVs)

    # catch unexpected error
    except Exception as e:
        return unexpected_error_response(e)


@services.route("/search_services/<query>", methods=["GET"])
def search_services_(query):
    return search_services(query)
