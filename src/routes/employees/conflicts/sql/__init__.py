from src.mysql.execute_sql_file.many_queries import exe_queries


# to build the required procedures:
def create_employee_conflicts_procs():
    print("\033[36m" + "create_conflicts_procs" + "\033[0m")
    exe_queries(__file__, "fn_get_conflicting_schedule_id.sql")
    exe_queries(__file__, "sp_get_emp_ld_conflicts.sql")
    exe_queries(__file__, "sp_get_schedule_conflicts.sql")
    exe_queries(__file__, "sp_scan_ELD_conflicts.sql")
    exe_queries(__file__, "sp_scan_schedule_conflicts.sql")

    print()
