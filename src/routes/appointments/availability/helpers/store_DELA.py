import json
from src.mysql.procedures.call_2D_proc import call_2D_proc


# send DELA to the mysql server
def store_DELA(DELA, DELA_id):
    # convert to json
    slots = json.dumps(DELA)

    # call mysql proc to process data
    call_2D_proc("sp_add_DELA_slots", DELA_id, slots)
