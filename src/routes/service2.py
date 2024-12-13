from flask import Blueprint, jsonify

service2 = Blueprint('service2', __name__)

@service2.route('/',methods=['GET'])
def index():
    return jsonify(message="Hello from service 2!")
