from src.mysql.execute_sql_file.many_queries import exe_queries


def create_tables():
    print("\033[94m" + "create_tables" + "\033[0m")

    exe_queries(__file__, "authentication/phone_numbers.sql")
    exe_queries(__file__, "authentication/sp_add_phone_num_tokens.sql")
    exe_queries(__file__, "authentication/phone_num_tokens.sql")
    exe_queries(__file__, "authentication/authentication.sql")
    exe_queries(__file__, "authentication/login_attempts.sql")
    exe_queries(__file__, "authentication/otp_codes.sql")
    exe_queries(__file__, "authentication/otp_rate_limits.sql")
    exe_queries(__file__, "authentication/user_sessions.sql")
    exe_queries(__file__, "authentication/unconfirmed_salts.sql")
    exe_queries(__file__, "authentication/users_trackers.sql")

    exe_queries(__file__, "accounts/blacklist.sql")
    exe_queries(__file__, "accounts/blacklist_trackers.sql")
    exe_queries(__file__, "accounts/business_links.sql")
    exe_queries(__file__, "accounts/colors.sql")
    exe_queries(__file__, "accounts/contacts.sql")
    exe_queries(__file__, "accounts/profiles.sql")

    exe_queries(__file__, "employees/employees.sql")
    exe_queries(__file__, "employees/schedules.sql")
    exe_queries(__file__, "employees/opening_hours.sql")

    exe_queries(__file__, "services/categories.sql")
    exe_queries(__file__, "services/services.sql")
    exe_queries(__file__, "employees/employee_services.sql")

    exe_queries(__file__, "appointments/appo_details.sql")
    exe_queries(__file__, "appointments/appo_notes.sql")
    exe_queries(__file__, "appointments/appo_notifications.sql")
    exe_queries(__file__, "appointments/DELAs.sql")
    exe_queries(__file__, "appointments/DELA_slots.sql")
    exe_queries(__file__, "appointments/appos_trackers.sql")
    exe_queries(__file__, "appointments/canceled_appos.sql")
    exe_queries(__file__, "appointments/canceled_trackers.sql")
    exe_queries(__file__, "appointments/daily_notes.sql")
    exe_queries(__file__, "appointments/saved_appos.sql")
    exe_queries(__file__, "appointments/saved_trackers.sql")
    exe_queries(__file__, "employees/appo_employees.sql")

    exe_queries(__file__, "services/add_ons/add_on_services.sql")
    exe_queries(__file__, "services/add_ons/AOS_options.sql")

    exe_queries(__file__, "services/durations/duration_conflicts.sql")
    exe_queries(__file__, "services/durations/durations.sql")

    # conflicts
    exe_queries(__file__, "employees/schedule_conflicts.sql")
    exe_queries(__file__, "employees/ELD_conflicts.sql")
    exe_queries(__file__, "services/SLD_conflicts.sql")

    # tokens
    exe_queries(__file__, "tokens/sp_update_name_tokens.sql")
    exe_queries(__file__, "tokens/name_tokens.sql")
