from flask import Flask, jsonify
from flask_cors import CORS
from src.routes.service1 import service1
from src.routes.service2 import service2
from src.routes.authentication import auth_routes

from src.mysql.setup_db import setup_db_on_mysql


app = Flask(__name__, static_folder="static", static_url_path="")

# Enable CORS for all routes
CORS(app)

# Call the setup_mysql function to create/rebuild the database
setup_db_on_mysql()

# Register blueprints for API services
app.register_blueprint(service1, url_prefix="/api/service1")
app.register_blueprint(service2, url_prefix="/api/service2")
app.register_blueprint(auth_routes, url_prefix="/api/authentication")


# Example API route
@app.route("/api")
def api():
    return jsonify(message="Hello from Flask API!")


# Route for the favicon
@app.route("/favicon.ico")
def favicon():
    return app.send_static_file("favicon.ico")


@app.route("/")
def index():
    return app.send_static_file("index.html")


# Catch-all route for Vue Router fallback
@app.route("/<any>", methods=["GET"])
def catch_all(any):
    return app.send_static_file("index.html")


# start the app:
if __name__ == "__main__":
    app.run(debug=False)
