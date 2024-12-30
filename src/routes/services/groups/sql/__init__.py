from src.mysql.execute_sql_file.many_queries import exe_queries


# to build the required procedures:
def create_services_groups_sps():
    print("\033[36m" + "create_services_groups_sps" + "\033[0m")
    exe_queries(__file__, "sp_add_group.sql")
    exe_queries(__file__, "sp_remove_group.sql")
    print()
