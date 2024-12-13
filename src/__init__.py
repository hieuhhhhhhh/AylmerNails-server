from flask import Flask, jsonify
from flask_cors import CORS
from .routes.service1 import service1
from .routes.service2 import service2

def create_app():
    app = Flask(__name__)
    CORS(app)

    # Register blueprints
    app.register_blueprint(service1, url_prefix='/service1')
    app.register_blueprint(service2, url_prefix='/service2')

    @app.route('/')
    def index():
        return jsonify(message="Hello from entrance!")

    return app
