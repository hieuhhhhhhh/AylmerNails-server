from src.mysql.execute_sql_file.many_queries import exe_queries


def create_tables():
    print("\033[94m" + "create_tables" + "\033[0m")

    exe_queries(__file__, "authentication/authentication.sql")
    exe_queries(__file__, "authentication/sms_verify_codes.sql")
    exe_queries(__file__, "authentication/user_sessions.sql")
    exe_queries(__file__, "authentication/unconfirmed_salts.sql")

    exe_queries(__file__, "employees/employees.sql")
    exe_queries(__file__, "employees/schedules.sql")
    exe_queries(__file__, "employees/opening_hours.sql")

    exe_queries(__file__, "services/category_groups.sql")
    exe_queries(__file__, "services/categories.sql")
    exe_queries(__file__, "services/services.sql")
    exe_queries(__file__, "employees/employee_services.sql")

    exe_queries(__file__, "appointments/appo_details.sql")
    exe_queries(__file__, "appointments/appo_notes.sql")
    exe_queries(__file__, "appointments/DELA.sql")
    exe_queries(__file__, "appointments/DELA_slots.sql")

    exe_queries(__file__, "services/add_ons/add_on_services.sql")
    exe_queries(__file__, "services/add_ons/AOS_options.sql")

    exe_queries(__file__, "services/lengths/service_lengths.sql")
    exe_queries(__file__, "services/lengths/SLVs.sql")

    # conflicts
    exe_queries(__file__, "employees/schedule_conflicts.sql")
    exe_queries(__file__, "employees/ELD_conflicts.sql")
    exe_queries(__file__, "services/SLD_conflicts.sql")
    exe_queries(__file__, "services/lengths/service_length_conflicts.sql")
