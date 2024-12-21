from src.mysql.call_sp import call_sp
from .get_stored_pw import get_stored_pw
import bcrypt


# handle credentials from client side:
def request_log_in(phone_number, password):

    user_id, hashed = get_stored_pw(phone_number)

    # Validate the entered password against the stored hash
    if bcrypt.checkpw(password.encode("utf-8"), hashed.encode("utf-8")):
        session_id, session_salt = call_sp("sp_add_session", user_id)[0]
    else:
        return
