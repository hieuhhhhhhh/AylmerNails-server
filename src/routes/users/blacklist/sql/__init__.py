from src.mysql.execute_sql_file.many_queries import exe_queries


# to build the required procedures:
def create_blacklist_procs():
    print("\033[36m" + "create_blacklist_procs" + "\033[0m")
    exe_queries(__file__, "sp_ban_unban_phone_num.sql")
    exe_queries(__file__, "sp_get_blacklist_last_tracked.sql")
    exe_queries(__file__, "sp_search_blacklist.sql")

    print()
