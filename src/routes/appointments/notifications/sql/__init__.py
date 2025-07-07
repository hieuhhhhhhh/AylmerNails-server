from src.mysql.execute_sql_file.many_queries import exe_queries


# to build the required procedures:
def create_appo_notifications_procs():
    print("\033[36m" + "create_appo_notifications_procs" + "\033[0m")
    exe_queries(__file__, "sp_get_bookings_last_tracked.sql")
    exe_queries(__file__, "sp_get_canceled_last_tracked.sql")
    exe_queries(__file__, "sp_get_new_appo_count.sql")
    exe_queries(__file__, "sp_get_new_canceled_count.sql")
    exe_queries(__file__, "sp_get_new_user_count.sql")
    exe_queries(__file__, "sp_search_bookings.sql")
    exe_queries(__file__, "sp_search_canceled_appos.sql")

    print()
