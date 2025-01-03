from src.mysql.execute_sql_file.many_queries import exe_queries


# to build the required procedures:
def create_appointments_add_appo_sps():
    print("\033[36m" + "create_appointments_add_appo_sps" + "\033[0m")
    exe_queries(__file__, "fn_find_conflicting_appo.sql")
    exe_queries(__file__, "fn_get_appos.sql")
    exe_queries(__file__, "sp_add_appo_by_DELA.sql")
    exe_queries(__file__, "sp_add_appo_manually.sql")
    exe_queries(__file__, "sp_restrict_appo_details.sql")

    print()
