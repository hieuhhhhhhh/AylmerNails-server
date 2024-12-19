from flask import Flask, jsonify
from flask_cors import CORS
from src.routes.authentication import authentication

from src.mysql.setup_db import setup_db_on_mysql, create_procedures

# create the database if not exists
setup_db_on_mysql()

# re-create required stored procedures
create_procedures()

# initialize flask app
app = Flask(__name__, static_folder="static", static_url_path="")

# Enable CORS for all routes
CORS(app)

# register blueprints (groups of routes)
app.register_blueprint(authentication, url_prefix="/api/authentication")


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


# start the app:
if __name__ == "__main__":
    app.run(debug=False)
