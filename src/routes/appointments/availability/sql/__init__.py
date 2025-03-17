from src.mysql.execute_sql_file.many_queries import exe_queries


# to build the required procedures:
def create_appointments_availability_sps():
    print("\033[36m" + "create_appointments_availability_sps" + "\033[0m")
    exe_queries(__file__, "fn_get_interval_percent.sql")
    exe_queries(__file__, "sp_add_DELA_slots.sql")
    exe_queries(__file__, "sp_get_DELAs_or_appo_lists.sql")
    exe_queries(__file__, "sp_remove_DELA.sql")

    print()
