import json
from src.mysql.procedures.call_3D_proc import call_3D_proc
import eventlet


# send DELA to the mysql server
def store_DELA_slots(slots, DELA_id):
    # if empty, ignore
    if len(slots) > 0:
        # call mysql proc to process data in another thread
        eventlet.spawn_n(call_3D_proc, "sp_add_DELA_slots", DELA_id, json.dumps(slots))
