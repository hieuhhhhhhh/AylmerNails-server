from src.mysql.execute_sql_file.many_queries import exe_queries


# to build the required procedures:
def create_appointments_appos_sps():
    print("\033[36m" + "create_appointments_appos_sps" + "\033[0m")
    exe_queries(__file__, "sp_add_appo_by_DELA.sql")
    exe_queries(__file__, "sp_add_appo_manually.sql")
    exe_queries(__file__, "sp_get_appo_details.sql")
    exe_queries(__file__, "sp_get_appo_info.sql")
    exe_queries(__file__, "sp_get_daily_appos.sql")
    exe_queries(__file__, "sp_save_appo_employees.sql")
    exe_queries(__file__, "sp_update_appo.sql")
    exe_queries(__file__, "sp_validate_client_booking.sql")
    exe_queries(__file__, "sp_validate_guest_booking.sql")
    exe_queries(__file__, "sp_write_appo_note.sql")

    print()
