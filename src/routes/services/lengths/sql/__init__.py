from src.mysql.execute_sql_file.many_queries import exe_queries


# to build the required procedures:
def create_services_lengths_sps():
    print("\033[36m" + "create_services_lengths_sps" + "\033[0m")
    exe_queries(__file__, "fn_find_conflicting_length.sql")
    exe_queries(__file__, "sp_add_service_length.sql")
    exe_queries(__file__, "sp_get_service_length.sql")
    exe_queries(__file__, "sp_scan_service_length_conflicts.sql")
    print()
