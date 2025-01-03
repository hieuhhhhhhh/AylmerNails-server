from src.mysql.execute_sql_file.many_queries import exe_queries


def create_tables():
    print("\033[94m" + "create_tables" + "\033[0m")

    exe_queries(__file__, "authentication/authentication.sql")
    exe_queries(__file__, "authentication/sms_verify_codes.sql")
    exe_queries(__file__, "authentication/user_sessions.sql")
    exe_queries(__file__, "authentication/unconfirmed_salts.sql")

    exe_queries(__file__, "services/add_ons/add_on_services.sql")
    exe_queries(__file__, "services/add_ons/AOS_options.sql")
    exe_queries(__file__, "services/length/categories.sql")
    exe_queries(__file__, "services/length/category_groups.sql")
    exe_queries(__file__, "services/length/employee_services.sql")
    exe_queries(__file__, "services/length/services.sql")
    exe_queries(__file__, "services/length/SLD_conflicts.sql")
