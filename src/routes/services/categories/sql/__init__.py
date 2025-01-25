from src.mysql.execute_sql_file.many_queries import exe_queries


# to build the required procedures:
def create_services_categories_sps():
    print("\033[36m" + "create_services_categories_sps" + "\033[0m")
    exe_queries(__file__, "sp_add_category.sql")
    exe_queries(__file__, "sp_get_categories.sql")
    exe_queries(__file__, "sp_remove_category.sql")

    print()
