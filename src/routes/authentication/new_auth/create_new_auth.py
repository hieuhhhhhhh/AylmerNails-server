from src.mysql.call_sp import call_sp


def create_new_auth(phone_number):
    new_pw = get_new_password(phone_number)

    # if a new password was inserted earlier, overwrite the old password
    if new_pw:
        call_sp("sp_new_auth", phone_number, new_pw)


def get_new_password(phone_number):
    result = call_sp("sp_get_new_pw", phone_number)
    return result[0][0] if result else None
