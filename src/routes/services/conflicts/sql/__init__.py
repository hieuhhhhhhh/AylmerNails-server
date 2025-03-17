from src.mysql.execute_sql_file.many_queries import exe_queries


# to build the required procedures:
def create_conflicts_procs():
    print("\033[36m" + "create_conflicts_procs" + "\033[0m")
    exe_queries(__file__, "sp_get_duration_conflicts.sql")
    exe_queries(__file__, "sp_get_service_ld_conflicts.sql")
    exe_queries(__file__, "sp_scan_duration_conflicts.sql")
    exe_queries(__file__, "sp_scan_SLD_conflicts.sql")

    print()
