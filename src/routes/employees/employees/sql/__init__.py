from src.mysql.execute_sql_file.many_queries import exe_queries


# to build the required procedures:
def create_employees_employees_sps():
    print("\033[36m" + "create_employees_employees_sps" + "\033[0m")
    exe_queries(__file__, "sp_add_employee.sql")
    exe_queries(__file__, "fn_get_stored_intervals.sql")
    exe_queries(__file__, "sp_get_service_employees.sql")
    exe_queries(__file__, "sp_scan_ELD_conflicts.sql")
    exe_queries(__file__, "sp_set_ELD.sql")
    exe_queries(__file__, "sp_set_employee_services.sql")

    print()
