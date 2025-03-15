from src.mysql.execute_sql_file.many_queries import exe_queries


# to build the required procedures:
def create_contacts_procs():
    print("\033[36m" + "create_contacts_procs" + "\033[0m")
    exe_queries(__file__, "sp_update_contact.sql")
    exe_queries(__file__, "sp_search_contacts.sql")
    print()
