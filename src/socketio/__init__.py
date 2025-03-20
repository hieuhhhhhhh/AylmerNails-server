from flask_socketio import SocketIO
from .get_new_appo_count import get_new_appo_count

socketio = SocketIO()


def create_socket(app):
    socketio.init_app(app, cors_allowed_origins="*")

    # event: client connects
    @socketio.on("get_new_appo_count")
    def get_new_appo_count_(data):
        # fetch token from the client
        token = data.get("token", None)
        print(f"Client requested, token: {token}")

        # fetch and return result
        count = get_new_appo_count(token)
        socketio.emit("new_appo_count", {"count": count})

    @socketio.on("disconnect")
    def disconnect():
        print("client gone")

    return socketio


def emit_booking():
    socketio.emit("new_appo_booked")
