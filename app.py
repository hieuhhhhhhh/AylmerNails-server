from flask import Flask, jsonify
from flask_cors import CORS
from src.routes.authentication import authentication
from src.routes.services import services
from src.routes.employees import employees
from src.routes.appointments import appointments
from src.routes.users import users
from src.routes.business_links import business_links

from src.socketio import create_socket
from src.mysql.setup_db import setup_db_on_mysql
from dotenv import load_dotenv
import os

# create the database if not exists
setup_db_on_mysql()


# initialize flask app
app = Flask(__name__, static_folder="static")

# Load env variables to the app
load_dotenv()
app.config["TWILIO_SID"] = os.getenv("TWILIO_SID")
app.config["TWILIO_TOKEN"] = os.getenv("TWILIO_TOKEN")
app.config["TOKEN_SALT"] = os.getenv("TOKEN_SALT")
app.config["BUSINESS_PHONE"] = os.getenv("BUSINESS_PHONE")

# Check if env vars are being loaded (for debugging)
print("TWILIO_SID:", os.getenv("TWILIO_SID"))
print("TWILIO_TOKEN:", os.getenv("TWILIO_TOKEN"))
print("TOKEN_SALT:", os.getenv("TOKEN_SALT"))
print("BUSINESS_PHONE:", os.getenv("BUSINESS_PHONE"))


# Enable CORS for all routes
CORS(app, supports_credentials=True)

# register blueprints (groups of routes)
app.register_blueprint(authentication, url_prefix="/api/authentication")
app.register_blueprint(services, url_prefix="/api/services")
app.register_blueprint(employees, url_prefix="/api/employees")
app.register_blueprint(appointments, url_prefix="/api/appointments")
app.register_blueprint(users, url_prefix="/api/users")
app.register_blueprint(business_links, url_prefix="/api/business_links")


@app.route("/", defaults={"path": ""})
@app.route("/<path:path>")
def serve_spa(path):
    if path != "" and os.path.exists(os.path.join(app.static_folder, path)):
        return app.send_static_file(path)
    return app.send_static_file("index.html")


# create socket
socketio = create_socket(app)


# start the app:
if __name__ == "__main__":
    socketio.run(app, debug=False)
