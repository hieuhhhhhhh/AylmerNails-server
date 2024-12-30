from src.mysql.execute_sql_file.many_queries import exe_queries


# to build the required procedures:
def create_services_services_sps():
    print("\033[36m" + "create_services_services_sps" + "\033[0m")
    exe_queries(__file__, "sp_add_service_length.sql")
    exe_queries(__file__, "sp_add_service.sql")
    exe_queries(__file__, "sp_remove_service.sql")
    print()
