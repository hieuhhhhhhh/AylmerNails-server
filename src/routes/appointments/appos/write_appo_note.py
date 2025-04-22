from src.mysql.procedures.call_3D_proc import call_3D_proc


def write_appo_note(session, appo_id, note):

    # call mysql proc to process data
    call_3D_proc(
        "sp_write_appo_note",
        session,
        appo_id,
        note,
    )
    return "request done", 200
