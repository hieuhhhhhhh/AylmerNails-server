from flask import Flask, jsonify
from flask_cors import CORS
from .routes.service1 import service1
from .routes.service2 import service2

def create_app():
    app = Flask(__name__, static_folder="static", static_url_path="")

    # Enable CORS for all routes
    CORS(app)

    # Register blueprints for API services
    app.register_blueprint(service1, url_prefix='/api/service1')
    app.register_blueprint(service2, url_prefix='/api/service2')

    # Example API route
    @app.route('/api')
    def api():
        return jsonify(message="Hello from Flask API!")
    
    @app.route('/favicon.ico')
    def favicon():
        return app.send_static_file('favicon.ico')
    
    # Serve Vue's index.html at the root URL
    @app.route('/')
    def index():
        return app.send_static_file('index.html')

    # Catch-all route for Vue Router fallback
    @app.route('/<path>', methods=['GET'])
    def catch_all(path):
        return app.send_static_file('index.html')

    return app