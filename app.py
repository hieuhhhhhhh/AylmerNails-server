from flask import Flask, jsonify
from flask_cors import CORS
from src.routes.authentication import authentication
from src.routes.services import services
from src.routes.employees import employees
from src.routes.appointments import appointments
from src.socketio import create_socket
from src.mysql.setup_db import setup_db_on_mysql
from dotenv import load_dotenv
import os

# create the database if not exists
setup_db_on_mysql()

# initialize flask app
app = Flask(__name__, static_folder="static", static_url_path="")

# Load env variables to the app
load_dotenv()
app.config["TWILIO_SID"] = os.getenv("TWILIO_SID")
app.config["TWILIO_TOKEN"] = os.getenv("TWILIO_TOKEN")
app.config["TOKEN_SALT"] = os.getenv("TOKEN_SALT")
app.config["BUSINESS_PHONE"] = os.getenv("BUSINESS_PHONE")

# Enable CORS for all routes
CORS(app, supports_credentials=True)

# register blueprints (groups of routes)
app.register_blueprint(authentication, url_prefix="/api/authentication")
app.register_blueprint(services, url_prefix="/api/services")
app.register_blueprint(employees, url_prefix="/api/employees")
app.register_blueprint(appointments, url_prefix="/api/appointments")


# add route
@app.route("/api")
def api():
    return jsonify(message="Hello from Flask API!")


# add route
@app.route("/favicon.ico")
def favicon():
    return app.send_static_file("favicon.ico")


# add route
@app.route("/")
def index():
    return app.send_static_file("index.html")


# add route
@app.route("/<any>", methods=["GET"])
def catch_all(any):
    return app.send_static_file("index.html")


# create socket
socketio = create_socket(app)


# start the app:
if __name__ == "__main__":
    socketio.run(app, debug=False)
