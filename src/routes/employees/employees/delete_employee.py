from src.mysql.procedures.call_3D_proc import call_3D_proc


def delete_employee(session, employee_id):
    # call mysql proc to process data
    call_3D_proc("sp_delete_employee", session, employee_id)

    return "deleted", 200
