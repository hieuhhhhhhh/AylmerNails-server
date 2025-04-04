from src.mysql.execute_sql_file.many_queries import exe_queries


# to build the required procedures:
def create_employees_employees_sps():
    print("\033[36m" + "create_employees_employees_sps" + "\033[0m")

    exe_queries(__file__, "fn_get_stored_intervals.sql")
    exe_queries(__file__, "sp_add_employee.sql")
    exe_queries(__file__, "sp_get_colors.sql")
    exe_queries(__file__, "sp_get_employee_details.sql")
    exe_queries(__file__, "sp_get_employees.sql")
    exe_queries(__file__, "sp_get_ESs.sql")
    exe_queries(__file__, "sp_set_ESs.sql")
    exe_queries(__file__, "sp_store_alias_tokens.sql")
    exe_queries(__file__, "sp_update_employee_info.sql")

    print()
