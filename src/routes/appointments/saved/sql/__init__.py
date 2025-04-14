from src.mysql.execute_sql_file.many_queries import exe_queries


# to build the required procedures:
def create_saved_appos_procs():
    print("\033[36m" + "create_saved_appos_procs" + "\033[0m")
    exe_queries(__file__, "sp_get_saved_last_tracked.sql")
    exe_queries(__file__, "sp_save_appo.sql")
    exe_queries(__file__, "sp_search_saved_appos.sql")

    print()
