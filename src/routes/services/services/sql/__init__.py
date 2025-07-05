from src.mysql.execute_sql_file.many_queries import exe_queries


# to build the required procedures:
def create_services_services_sps():
    print("\033[36m" + "create_services_services_sps" + "\033[0m")
    exe_queries(__file__, "sp_add_AOS.sql")
    exe_queries(__file__, "sp_add_service.sql")
    exe_queries(__file__, "sp_delete_service.sql")
    exe_queries(__file__, "sp_get_AOSs.sql")
    exe_queries(__file__, "sp_get_services.sql")
    exe_queries(__file__, "sp_get_SEs.sql")
    exe_queries(__file__, "sp_get_service_details.sql")
    exe_queries(__file__, "sp_get_service_preview.sql")
    exe_queries(__file__, "sp_set_service_employees.sql")
    exe_queries(__file__, "sp_store_name_tokens.sql")
    exe_queries(__file__, "sp_update_service_info.sql")
    exe_queries(__file__, "sp_update_SEs.sql")

    print()
