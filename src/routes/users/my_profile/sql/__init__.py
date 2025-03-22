from src.mysql.execute_sql_file.many_queries import exe_queries


# to build the required procedures:
def create_my_profile_procs():
    print("\033[36m" + "create_users_procs" + "\033[0m")
    exe_queries(__file__, "sp_get_my_profile.sql")

    print()
