from src.mysql.procedures.call_3D_proc import call_3D_proc


def remove_category(session, cate_id):
    # call mysql proc to process data
    call_3D_proc("sp_remove_category", session, cate_id)

    return "removed!", 200
