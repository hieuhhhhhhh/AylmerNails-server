from src.mysql.procedures.call_3D_proc import call_3D_proc


def delete_service(session, service_id):
    # call mysql proc to process data
    call_3D_proc("sp_delete_service", session, service_id)

    return "deleted", 200
