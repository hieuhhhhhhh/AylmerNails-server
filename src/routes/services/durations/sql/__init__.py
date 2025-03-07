from src.mysql.execute_sql_file.many_queries import exe_queries


# to build the required procedures:
def create_services_durations_procs():
    print("\033[36m" + "create_services_durations_procs" + "\033[0m")
    exe_queries(__file__, "fn_calculate_appo_duration.sql")
    exe_queries(__file__, "fn_calculate_duration.sql")
    exe_queries(__file__, "sp_get_appo_duration.sql")
    exe_queries(__file__, "sp_scan_duration_conflicts.sql")
    exe_queries(__file__, "sp_update_durations.sql")
    print()
