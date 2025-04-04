from .read_token import read_token
from src.mysql.procedures.call_3D_proc import call_3D_proc


def get_new_canceled_count(token):
    session = read_token(token)

    # call mysql proc to process data
    count = call_3D_proc("sp_get_new_canceled_count", session)[0][0][0]

    return count
