from src.mysql.procedures.call_3D_proc import call_3D_proc


def move_cate_up(session, cate_id):
    # call mysql proc to process data
    call_3D_proc("sp_move_cate_up", session, cate_id)

    return "succeeded", 200
