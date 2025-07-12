from flask_socketio import SocketIO
from .get_new_appo_count import get_new_appo_count
from .get_new_canceled_count import get_new_canceled_count
from .get_new_user_count import get_new_user_count
from .get_new_saved_count import get_new_saved_count
from .get_new_blacklist_count import get_new_blacklist_count


socketio = SocketIO()


def create_socket(app):
    socketio.init_app(app, cors_allowed_origins="*")

    # event
    @socketio.on("get_new_appo_count")
    def get_new_appo_count_(data):
        # fetch token from the client
        token = data.get("token", None)
        print(f"Client requested, token: {token}")

        # fetch and return result
        count = get_new_appo_count(token)
        socketio.emit("new_appo_count", {"count": count})

    # event
    @socketio.on("get_new_canceled_count")
    def get_new_canceled_count_(data):
        # fetch token from the client
        token = data.get("token", None)
        print(f"Client requested, token: {token}")

        # fetch and return result
        count = get_new_canceled_count(token)
        socketio.emit("new_canceled_count", {"count": count})

    # event
    @socketio.on("get_new_user_count")
    def get_new_user_count_(data):
        # fetch token from the client
        token = data.get("token", None)
        print(f"Client requested, token: {token}")

        # fetch and return result
        count = get_new_user_count(token)
        socketio.emit("new_user_count", {"count": count})

    # event
    @socketio.on("get_new_saved_count")
    def get_new_saved_count_(data):
        # fetch token from the client
        token = data.get("token", None)
        print(f"Client requested, token: {token}")

        # fetch and return result
        count = get_new_saved_count(token)
        socketio.emit("new_saved_count", {"count": count})

    # event
    @socketio.on("get_new_blacklist_count")
    def get_new_saved_count_(data):
        # fetch token from the client
        token = data.get("token", None)
        print(f"Client requested, token: {token}")

        # fetch and return result
        count = get_new_blacklist_count(token)
        socketio.emit("new_blacklist_count", {"count": count})

    # event
    @socketio.on("disconnect")
    def disconnect():
        print("client gone")

    @socketio.on("connect")
    def connect():
        print("client connected")

    return socketio


def emit_booking():
    socketio.emit("new_appo_booked")


def emit_canceling():
    socketio.emit("new_appo_canceled")


def emit_signing_up():
    socketio.emit("new_user_created")


def emit_banning():
    socketio.emit("new_phone_num_banned")


def emit_saving():
    socketio.emit("new_appo_saved")
