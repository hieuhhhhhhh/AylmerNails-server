from src.mysql.execute_sql_file.many_queries import exe_queries


# to build the required procedures:
def create_employees_schedules_sps():
    print("\033[36m" + "create_employees_schedules_sps" + "\033[0m")
    exe_queries(__file__, "fn_find_conflicting_schedule.sql")
    exe_queries(__file__, "sp_add_schedule.sql")
    exe_queries(__file__, "sp_clean_old_schedule_conflicts.sql")
    exe_queries(__file__, "sp_scan_schedule_conflicts.sql")

    print()
