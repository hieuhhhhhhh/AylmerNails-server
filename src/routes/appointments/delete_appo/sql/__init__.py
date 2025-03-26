from src.mysql.execute_sql_file.many_queries import exe_queries


# to build the required procedures:
def create_delete_appo_procs():
    print("\033[36m" + "create_delete_appo_procs" + "\033[0m")
    exe_queries(__file__, "sp_admin_remove_appo.sql")
    exe_queries(__file__, "sp_cancel_appo.sql")
    exe_queries(__file__, "sp_store_canceled_appo.sql")

    print()
