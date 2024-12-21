from src.mysql.call_sp import call_sp


# return a tuple [user_id, password]:
def get_stored_pw(phone_number):
    res = call_sp("sp_get_new_pw", phone_number)
    return res[0] if res else None
