from src.mysql.procedures.call_3D_proc import call_3D_proc


def write_daily_note(session, date, note):

    # call mysql proc to process data
    call_3D_proc(
        "sp_write_daily_note",
        session,
        date,
        note,
    )
    return "request done", 200
