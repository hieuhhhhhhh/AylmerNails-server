from src.mysql.execute_sql_file.many_queries import exe_queries


# to build the required procedures:
def create_profiles_procs():
    print("\033[36m" + "create_profiles_procs" + "\033[0m")
    exe_queries(__file__, "sp_get_all_users.sql")
    exe_queries(__file__, "sp_get_user_details.sql")
    exe_queries(__file__, "sp_update_user_role.sql")

    print()
