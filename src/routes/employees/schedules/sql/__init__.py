from src.mysql.execute_sql_file.many_queries import exe_queries


# to build the required procedures:
def create_employees_schedules_sps():
    print("\033[36m" + "create_employees_schedules_sps" + "\033[0m")
    exe_queries(__file__, "sp_get_opening_hours.sql")
    exe_queries(__file__, "sp_add_schedule.sql")
    exe_queries(__file__, "sp_get_employee_schedules.sql")

    print()
