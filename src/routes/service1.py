from flask import Blueprint, jsonify

service1 = Blueprint('service1', __name__)

@service1.route('/')
def index():
    return jsonify(message="Hello from service 1!")
