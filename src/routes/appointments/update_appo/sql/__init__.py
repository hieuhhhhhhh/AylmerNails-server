from src.mysql.execute_sql_file.many_queries import exe_queries


# to build the required procedures:
def create_appointments_update_appo_sps():
    print("\033[36m" + "create_appointments_update_appo_sps" + "\033[0m")
    exe_queries(__file__, "sp_remove_appo.sql")
    exe_queries(__file__, "sp_update_appo.sql")

    print()
