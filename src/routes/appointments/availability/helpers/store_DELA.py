import json
from src.mysql.procedures.call_3D_proc import call_3D_proc
from src.mysql.procedures.thread_pool import job_queue


# send DELA to the mysql server
def store_DELA(DELA, DELA_id):

    # call mysql proc to process data in another thread
    job_queue.put(lambda: call_3D_proc("sp_add_DELA_slots", DELA_id, json.dumps(DELA)))
