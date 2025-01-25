from src.mysql.procedures.call_3D_proc import call_3D_proc


def update_service_employees(session, service_id, employee_ids):
    # call mysql proc to process data
    call_3D_proc("sp_update_SEs", session, service_id, employee_ids)
    return "updated succesfully", 200
