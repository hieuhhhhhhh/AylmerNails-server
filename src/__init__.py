from flask import Flask, jsonify
from flask_cors import CORS
import mysql.connector
from mysql.connector import Error
from .routes.service1 import service1
from .routes.service2 import service2

# Import the setup function from testMySQL.py
from testMySQL import setup_mysql

# Function to fetch message from MySQL
def fetch_hello_message():
    # Database connection details
    host = 'localhost'  # Adjust if needed
    user = 'root'       # Adjust to your MySQL username
    password = '123Arcus.'  # Adjust to your MySQL password
    database_name = 'test_db'
    table_name = 'hello_table'
    
    try:
        # Establishing MySQL connection
        connection = mysql.connector.connect(
            host=host,
            user=user,
            password=password,
            database=database_name
        )

        if connection.is_connected():
            cursor = connection.cursor()
            cursor.execute(f"SELECT message FROM {table_name} WHERE id = 1")
            result = cursor.fetchone()
            
            if result:
                return result[0]  # Returns the message (i.e., 'Hello World')
            else:
                return "No message found in database"
    
    except Error as e:
        print(f"Error: {e}")
        return "Error connecting to the database"
    
    finally:
        if connection.is_connected():
            cursor.close()
            connection.close()

def create_app():
    app = Flask(__name__, static_folder="static", static_url_path="")

    # Call the setup_mysql function to create/rebuild the database
    setup_mysql()  # This ensures the DB is created before serving the app

    # Enable CORS for all routes
    CORS(app)

    # Register blueprints for API services
    app.register_blueprint(service1, url_prefix='/api/service1')
    app.register_blueprint(service2, url_prefix='/api/service2')

    # Example API route
    @app.route('/api')
    def api():
        return jsonify(message="Hello from Flask API!")
    
    # Route for the favicon
    @app.route('/favicon.ico')
    def favicon():
        return app.send_static_file('favicon.ico')
    
    # Serve the message from MySQL on the index route
    @app.route('/')
    def index():
        message = fetch_hello_message()  # Fetch message from DB
        return jsonify(message=message)  # Return the message as JSON

    # Catch-all route for Vue Router fallback
    @app.route('/<path>', methods=['GET'])
    def catch_all(path):
        return app.send_static_file('index.html')

    return app
